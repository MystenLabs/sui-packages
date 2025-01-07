module 0xa431b899aebedac487abaa0e34500a9013543785257b6bdbbf02562a91370099::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"IUS", b"SUIUS", b"\"IIUS is the first and only flipped meme on SUI. Nobody does it better like IUS. IUS stands out with its flip-themed concept, where everything from name to logo is all flipped. FLIPPED IS s s up oul lddp ou SI Noqop pos q l IS IS sups on s ld-p oud' u o u o loo s ll lddp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fb9728cb_369c_428d_8fb9_6ed9b4fd254f_8ad6454383.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

