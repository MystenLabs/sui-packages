module 0xdd010b3376422ac3554065bd15ddbedbb0f53b569e7d4e96641e7283b76a13a7::mist_bucket {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MistBucket has store, key {
        id: 0x2::object::UID,
        threshold: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MistBucket{
            id        : 0x2::object::new(arg0),
            threshold : 1000,
        };
        0x2::transfer::public_share_object<MistBucket>(v1);
    }

    public fun set_threshold(arg0: &AdminCap, arg1: &mut MistBucket, arg2: u64) {
        arg1.threshold = arg2;
    }

    public fun take<T0>(arg0: &AdminCap, arg1: &mut MistBucket, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.id, 0x1::type_name::get<T0>());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v0, 0x2::coin::value<T0>(v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun threshold(arg0: &MistBucket) : u64 {
        arg0.threshold
    }

    public fun wipe_mist<T0>(arg0: &mut MistBucket, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else if (v0 > arg0.threshold) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            let v1 = 0x1::type_name::get<T0>();
            if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1)) {
                0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, v1, 0x2::coin::zero<T0>(arg2));
            };
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, v1), arg1);
        };
    }

    public fun wipe_mist_custom_threshold<T0>(arg0: &mut MistBucket, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else if (v0 > arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            let v1 = 0x1::type_name::get<T0>();
            if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1)) {
                0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, v1, 0x2::coin::zero<T0>(arg3));
            };
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, v1), arg1);
        };
    }

    // decompiled from Move bytecode v6
}

