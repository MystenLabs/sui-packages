module 0xf3f67ada713b0ea82ca024e68b6a582896ec823d677e4b2736ceaff3e4ae318f::sulaus {
    struct SULAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULAUS>(arg0, 6, b"SULAUS", b"SUILAUS", b"Little Fish, Big Dream. Riding the wave into the next generation of meme tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OS_Yw_Em_G_400x400_c39b7e9422.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULAUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

