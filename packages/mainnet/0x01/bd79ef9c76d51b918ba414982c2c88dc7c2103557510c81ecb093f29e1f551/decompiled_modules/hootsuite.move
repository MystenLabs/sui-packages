module 0x1bd79ef9c76d51b918ba414982c2c88dc7c2103557510c81ecb093f29e1f551::hootsuite {
    struct HOOTSUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOTSUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOTSUITE>(arg0, 6, b"HOOTSUITE", b"Hootsuite", b"Social media tools, tips, news, and a shoulder to cry on for social pros since 2008. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0izx_PO_62_400x400_24ce363f79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOTSUITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOTSUITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

