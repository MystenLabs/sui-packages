module 0x648a2b9bc8e212440a411f56dc2c5a35ff2db55569bf1bd7249b33aa42506fec::riko {
    struct RIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIKO>(arg0, 6, b"RIKO", b"RIKOSUI", b"So, one day, fun met courage, and that's how Riko, http://Gra.Fun's fearless pet, was born.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x2a900573082c58053377e54642038fa46f19a8a2_7e76948c06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

