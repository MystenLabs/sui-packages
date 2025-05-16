module 0x852fa1787452c8be9a297c8979f753e0c26e9ed40f4b06f792b44705a9f82d22::hammer {
    struct HAMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMER>(arg0, 6, b"HAMMER", b"HAMMER SUI", b"hammer shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib3n6xy7ydjijz44tq3hpth5rj46vs5lwhwsiazzygk52tonp4l6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAMMER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

