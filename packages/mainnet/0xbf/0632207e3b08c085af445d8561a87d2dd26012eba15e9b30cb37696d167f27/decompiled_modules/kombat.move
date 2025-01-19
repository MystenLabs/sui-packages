module 0xbf0632207e3b08c085af445d8561a87d2dd26012eba15e9b30cb37696d167f27::kombat {
    struct KOMBAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMBAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMBAT>(arg0, 6, b"Kombat", b"Donald Kombat", b"Donald Trump joins Mortal Kombat to save America! His ultimate move? Make America Fatal Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_X4_Nv_Ad_X_1737245471083_raw_953c0edb8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMBAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMBAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

