module 0xc60207db8b28775dc5edb1e05ddc80a882e5b58b2cafde7c6ad6d3d67e882b4b::wait {
    struct WAIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIT>(arg0, 6, b"Wait", b"Theydontloveyoulikeiloveyou", b"Bringing in the TikTok trend, no X or community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3270_a51fdf79d5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

