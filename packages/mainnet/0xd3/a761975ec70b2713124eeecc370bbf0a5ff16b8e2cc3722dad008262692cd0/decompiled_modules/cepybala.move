module 0xd3a761975ec70b2713124eeecc370bbf0a5ff16b8e2cc3722dad008262692cd0::cepybala {
    struct CEPYBALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEPYBALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEPYBALA>(arg0, 6, b"Cepybala", b"Cepybala Suibala", b"Welcome to the herd, dear Cepybala. We are the next top meme coin and - to be honest - that is our only goal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_18_at_06_36_11_fb9e3cebdf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEPYBALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEPYBALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

