module 0x990988af9c51131d69eb34190334ec5914a0273b9992382fcabd12d7111e97f::zen {
    struct ZEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZEN>, arg1: 0x2::coin::Coin<ZEN>) {
        0x2::coin::burn<ZEN>(arg0, arg1);
    }

    fun init(arg0: ZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEN>(arg0, 9, b"ZEN", b"ZEN", b"Custom SUI Token: ZEN", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZEN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEN>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ZEN>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZEN>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

