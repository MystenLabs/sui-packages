module 0xa512b0f0c166e0189ef32d71887db63572389de833be171051cd8f6c494ba197::scroge {
    struct SCROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCROGE>(arg0, 6, b"SCROGE", b"Scroge On Sui", b"$SCROGE is the most unique Memecoin on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020332_ef27be72d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

