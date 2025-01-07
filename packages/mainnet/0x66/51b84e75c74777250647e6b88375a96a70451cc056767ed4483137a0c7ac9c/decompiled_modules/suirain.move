module 0x6651b84e75c74777250647e6b88375a96a70451cc056767ed4483137a0c7ac9c::suirain {
    struct SUIRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRAIN>(arg0, 6, b"SUIRAIN", b"SuiRain", b"\"Suirain - small drops, big waves!  A brand new meme coin on the Sui blockchain system, promising to bring endless laughter to the community. With a funny design and unique idea, Suirain is not only a currency but also a symbol of fun and solidarity.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ptichka_500_500_px_bcf009c5ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

