module 0x8d37ebcdc3bbb739e2563bd5ef1c99199d59415a23243c5e19d378a10a066651::asset {
    struct ASSET has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ASSET>, arg1: 0x2::coin::Coin<ASSET>) {
        0x2::coin::burn<ASSET>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<ASSET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASSET> {
        0x2::coin::mint<ASSET>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<ASSET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET>>(0x2::coin::mint<ASSET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ASSET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-iV7JBq1o41.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ASSET>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET>>(v1);
    }

    // decompiled from Move bytecode v6
}

