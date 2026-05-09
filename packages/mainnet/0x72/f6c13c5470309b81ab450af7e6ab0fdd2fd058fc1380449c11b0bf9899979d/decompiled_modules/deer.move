module 0x72f6c13c5470309b81ab450af7e6ab0fdd2fd058fc1380449c11b0bf9899979d::deer {
    struct DEER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEER>, arg1: 0x2::coin::Coin<DEER>) {
        0x2::coin::burn<DEER>(arg0, arg1);
    }

    fun init(arg0: DEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEER>(arg0, 9, b"DEER", b"DEER", b"Custom SUI Token: DEER", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEER>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEER>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEER>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<DEER>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEER>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

