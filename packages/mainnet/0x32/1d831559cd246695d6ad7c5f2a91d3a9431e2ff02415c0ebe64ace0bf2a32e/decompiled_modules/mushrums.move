module 0x321d831559cd246695d6ad7c5f2a91d3a9431e2ff02415c0ebe64ace0bf2a32e::mushrums {
    struct MUSHRUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHRUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHRUMS>(arg0, 6, b"MUSHRUMS", b"magic mushrums", b"magic mushrums project memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736521347357.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSHRUMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHRUMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

