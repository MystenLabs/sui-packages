module 0xe4ad53a9b39a3706814c31a383b2d4bc2ee254ef333634a75b16ef1b22c83fd1::starfish {
    struct STARFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARFISH>(arg0, 6, b"STARFISH", b"Starfish the Star", b"STARFISH is here to shine brighter than the rest on the Sui network. This resilient starfish clings to the waves, adapting and regenerating no matter what comes its way. Be a part of STARFISH's glow as it makes its mark in the Sui ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_59_124ad3c542.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

