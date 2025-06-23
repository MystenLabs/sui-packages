module 0xe75de1e992184dc0d79fa721b0b854a58df70f0abf1d0b4ded1ffa51c350154b::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    struct Drop has key {
        id: 0x2::object::UID,
        allocations: 0x2::table_vec::TableVec<Allocation>,
        recipients: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    struct Allocation has drop, store {
        recipient: address,
        tier: u8,
    }

    public fun add_allocation(arg0: &mut Drop, arg1: address, arg2: u8) {
        let v0 = Allocation{
            recipient : arg1,
            tier      : arg2,
        };
        0x2::table_vec::push_back<Allocation>(&mut arg0.allocations, v0);
    }

    fun add_voucher_to_recipient(arg0: &mut Drop, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.recipients, arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.recipients, arg1), arg2);
        } else {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.recipients, arg1, 0x2::vec_set::singleton<0x2::object::ID>(arg2));
        };
    }

    public fun execute(arg0: &mut Drop, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::u64::min(arg1, 0x2::table_vec::length<Allocation>(&arg0.allocations))) {
            let v1 = 0x2::table_vec::pop_back<Allocation>(&mut arg0.allocations);
            let v2 = 0xe75de1e992184dc0d79fa721b0b854a58df70f0abf1d0b4ded1ffa51c350154b::dmc_voucher::new(v1.tier, arg2);
            add_voucher_to_recipient(arg0, v1.recipient, 0x2::object::id<0xe75de1e992184dc0d79fa721b0b854a58df70f0abf1d0b4ded1ffa51c350154b::dmc_voucher::DmcVoucher>(&v2));
            0xe75de1e992184dc0d79fa721b0b854a58df70f0abf1d0b4ded1ffa51c350154b::dmc_voucher::transfer(v2, v1.recipient);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Drop{
            id          : 0x2::object::new(arg1),
            allocations : 0x2::table_vec::empty<Allocation>(arg1),
            recipients  : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg1),
        };
        0x2::transfer::transfer<Drop>(v0, @0x4d40228d5e6b4c2f739c73e4e42f751e5a2fef4cd6320c1e3ab91211149ed17b);
    }

    public fun recipient(arg0: &Drop, arg1: address) : &0x2::vec_set::VecSet<0x2::object::ID> {
        0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.recipients, arg1)
    }

    public fun recipients(arg0: &Drop) : &0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>> {
        &arg0.recipients
    }

    public fun remove_allocation(arg0: &mut Drop, arg1: u64) {
        0x2::table_vec::swap_remove<Allocation>(&mut arg0.allocations, arg1);
    }

    public fun reset_allocations(arg0: &mut Drop, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::u64::min(arg1, 0x2::table_vec::length<Allocation>(&arg0.allocations))) {
            0x2::table_vec::pop_back<Allocation>(&mut arg0.allocations);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

