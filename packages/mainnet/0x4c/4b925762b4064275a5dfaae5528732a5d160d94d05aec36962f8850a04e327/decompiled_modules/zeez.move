module 0x4c4b925762b4064275a5dfaae5528732a5d160d94d05aec36962f8850a04e327::zeez {
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

