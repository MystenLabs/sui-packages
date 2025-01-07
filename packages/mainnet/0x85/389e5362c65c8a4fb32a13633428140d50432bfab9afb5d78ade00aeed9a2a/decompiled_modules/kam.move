module 0x85389e5362c65c8a4fb32a13633428140d50432bfab9afb5d78ade00aeed9a2a::kam {
    struct KAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAM>(arg0, 6, b"KAM", b"KILL ALL MEMES", b"multi-chain memicide ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733374171221.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

