module 0x4fbb83c59096a2ab123d236aa0c365583cff50d61f16460e98657b291db3a334::nerdcandy {
    struct NERDCANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NERDCANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NERDCANDY>(arg0, 6, b"NERDCANDY", b"NerdyCandy", b"$Nerds,  is here to give you all some colorful profits and sweetness Aiming to invade the degens mouths and pockets So what you waiting for nerd? Buy $Nerds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nerdycandy_logo_cfd5772e44.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NERDCANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NERDCANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

