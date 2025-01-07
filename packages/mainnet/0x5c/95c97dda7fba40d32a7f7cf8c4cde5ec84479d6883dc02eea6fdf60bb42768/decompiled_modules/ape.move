module 0x5c95c97dda7fba40d32a7f7cf8c4cde5ec84479d6883dc02eea6fdf60bb42768::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 6, b"APE", b"Ape On SUI", b"Real apes ape into $APE! Tired of dogs and cats? $APE is the coin for real cryptocurrency enthusiasts. Apes stay together strong, apes never kill ape. No bored apes here either - ONLY $APE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_b4b92205a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APE>>(v1);
    }

    // decompiled from Move bytecode v6
}

