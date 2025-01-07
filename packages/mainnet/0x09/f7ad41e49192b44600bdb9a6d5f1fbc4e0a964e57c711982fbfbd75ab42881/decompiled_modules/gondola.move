module 0x9f7ad41e49192b44600bdb9a6d5f1fbc4e0a964e57c711982fbfbd75ab42881::gondola {
    struct GONDOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONDOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONDOLA>(arg0, 6, b"GONDOLA", b"gondola on sui", x"476f6e646f6c6120697320476f6e646f6c6121204a7573742061206865616420616e64206c6567732c206e6f2061726d736c6976696e672074686520647265616d210a4e6f2061776b776172642068616e647368616b65732c20476f6e646f6c6173206f75742068657265207265646566696e696e672077686174206974206d65616e7320746f2062652069636f6e69632e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_logo_192x192_8481a8accf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONDOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONDOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

