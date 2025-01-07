module 0xe17caca60e74ed95f673f855a5edec3428b58de04faef12767ca794f92ba7258::nltf {
    struct NLTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLTF>(arg0, 9, b"NLTF", b"NINJA LOW TAPER FADE$", b"Trying to make this coin as MASSIVE as the NINJA LOW TAPER FADE meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.kym-cdn.com/photos/images/original/002/735/702/1e5.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NLTF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLTF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NLTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

