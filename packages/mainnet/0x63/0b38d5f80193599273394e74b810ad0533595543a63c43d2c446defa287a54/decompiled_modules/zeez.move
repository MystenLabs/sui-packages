module 0x630b38d5f80193599273394e74b810ad0533595543a63c43d2c446defa287a54::zeez {
    struct ZEEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEEZ>(arg0, 6, b"Zeez", b"Zeezoo", b"The future greatest meme of  Sui water chain.  Zeezoo  lives in the water but it will touch the clouds. The Zeezoo coin brings fun, welth and joy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qplaou_cd6dbe5cf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

