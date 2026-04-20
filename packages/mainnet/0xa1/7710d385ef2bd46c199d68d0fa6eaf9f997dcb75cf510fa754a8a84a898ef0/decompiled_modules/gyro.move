module 0xa17710d385ef2bd46c199d68d0fa6eaf9f997dcb75cf510fa754a8a84a898ef0::gyro {
    struct GYRO has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GYRO>, arg1: 0x2::coin::Coin<GYRO>) {
        0x2::coin::burn<GYRO>(arg0, arg1);
    }

    fun init(arg0: GYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYRO>(arg0, 9, b"GYRO", b"GYRO", b"Custom SUI Token: GYRO", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GYRO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYRO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GYRO>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<GYRO>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GYRO>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

