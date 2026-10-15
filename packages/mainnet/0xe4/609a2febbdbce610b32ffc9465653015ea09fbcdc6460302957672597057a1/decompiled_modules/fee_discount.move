module 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount {
    struct FeeDiscountTable has key {
        id: 0x2::object::UID,
        max_discount_bp: u64,
        u64_padding: vector<u64>,
    }

    struct DiscountWriterCap has store {
        table_id: 0x2::object::ID,
    }

    struct DiscountKey has copy, drop, store {
        user: address,
    }

    struct FeeDiscountSet has copy, drop {
        table_id: 0x2::object::ID,
        user: address,
        discount_bp: u64,
    }

    public fun discount_bp_of(arg0: &FeeDiscountTable, arg1: address) : u64 {
        let v0 = DiscountKey{user: arg1};
        if (!0x2::dynamic_field::exists_<DiscountKey>(&arg0.id, v0)) {
            return 0
        };
        0x1::u64::min(*0x2::dynamic_field::borrow<DiscountKey, u64>(&arg0.id, v0), arg0.max_discount_bp)
    }

    public fun max_discount_bp(arg0: &FeeDiscountTable) : u64 {
        arg0.max_discount_bp
    }

    public fun mint_writer_cap(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &FeeDiscountTable, arg2: &0x2::tx_context::TxContext) : DiscountWriterCap {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg2);
        DiscountWriterCap{table_id: 0x2::object::id<FeeDiscountTable>(arg1)}
    }

    entry fun new_table(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg1);
        let v0 = FeeDiscountTable{
            id              : 0x2::object::new(arg1),
            max_discount_bp : 2000,
            u64_padding     : vector[],
        };
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<FeeDiscountTable>(&v0));
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 2000);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(5, 0, 0, 0x1::vector::empty<0x1::type_name::TypeName>(), v1, v2, arg1);
        0x2::transfer::share_object<FeeDiscountTable>(v0);
    }

    public fun set_discount_bp(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut FeeDiscountTable, arg2: &DiscountWriterCap, arg3: address, arg4: u64) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        assert!(arg2.table_id == 0x2::object::id<FeeDiscountTable>(arg1), 2801);
        assert!(arg4 <= arg1.max_discount_bp, 2800);
        let v0 = DiscountKey{user: arg3};
        if (0x2::dynamic_field::exists_<DiscountKey>(&arg1.id, v0)) {
            0x2::dynamic_field::remove<DiscountKey, u64>(&mut arg1.id, v0);
        };
        if (arg4 > 0) {
            0x2::dynamic_field::add<DiscountKey, u64>(&mut arg1.id, v0, arg4);
        };
        let v1 = FeeDiscountSet{
            table_id    : 0x2::object::id<FeeDiscountTable>(arg1),
            user        : arg3,
            discount_bp : arg4,
        };
        0x2::event::emit<FeeDiscountSet>(v1);
    }

    entry fun set_max_discount_bp(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut FeeDiscountTable, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        assert!(arg2 <= 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale(), 2802);
        arg1.max_discount_bp = arg2;
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<FeeDiscountTable>(arg1));
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(5, 0, 0, 0x1::vector::empty<0x1::type_name::TypeName>(), v0, v1, arg3);
    }

    public fun writer_cap_table_id(arg0: &DiscountWriterCap) : 0x2::object::ID {
        arg0.table_id
    }

    // decompiled from Move bytecode v7
}

