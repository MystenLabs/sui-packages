module 0x5d4cbe84ce19bce05fe0bff8a10342eef5c705e842576bc90aa610b9c57bc988::ks {
    struct KS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KS>(arg0, 6, b"KS", b"KITTYSPIN", b"the kitty keeps spinning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1919_e75d0d5cc2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KS>>(v1);
    }

    // decompiled from Move bytecode v6
}

