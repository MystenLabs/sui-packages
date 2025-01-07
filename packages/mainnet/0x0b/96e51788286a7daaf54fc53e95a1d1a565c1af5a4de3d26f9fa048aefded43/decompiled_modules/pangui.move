module 0xb96e51788286a7daaf54fc53e95a1d1a565c1af5a4de3d26f9fa048aefded43::pangui {
    struct PANGUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANGUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANGUI>(arg0, 6, b"Pangui", b"Pangui on Sui", x"48656c6c6f2c2049276d202450414e475549210a0a466f6c6b73206f6674656e20736179204920726573656d626c6520506570652c20627574204920616c776179730a636f7272656374207468656d496d20612070656e6775696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/panguiprofile_14d31998e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANGUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANGUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

