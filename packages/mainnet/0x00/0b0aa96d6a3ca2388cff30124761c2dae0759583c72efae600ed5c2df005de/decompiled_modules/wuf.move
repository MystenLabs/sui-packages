module 0xb0aa96d6a3ca2388cff30124761c2dae0759583c72efae600ed5c2df005de::wuf {
    struct WUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUF>(arg0, 6, b"WUF", b"wuf dog", b"wuf pump it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimemeshibafrfr_bb18a37523.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

