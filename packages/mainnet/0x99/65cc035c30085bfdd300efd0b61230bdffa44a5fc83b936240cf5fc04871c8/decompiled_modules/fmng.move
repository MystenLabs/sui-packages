module 0x9965cc035c30085bfdd300efd0b61230bdffa44a5fc83b936240cf5fc04871c8::fmng {
    struct FMNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMNG>(arg0, 6, b"FMNG", b"FUNKY MANGO", b"Sweet, tangy, and funky AF. Funky Mango is shaking up the meme market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_033302303_348bf711d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

