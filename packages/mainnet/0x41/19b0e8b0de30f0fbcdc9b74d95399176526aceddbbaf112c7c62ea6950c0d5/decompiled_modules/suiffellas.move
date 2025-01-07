module 0x4119b0e8b0de30f0fbcdc9b74d95399176526aceddbbaf112c7c62ea6950c0d5::suiffellas {
    struct SUIFFELLAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFFELLAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFFELLAS>(arg0, 6, b"SUIFFELLAS", b"Suiffellas", b"Dive into the world of SUIFFELLAS! This meme coin project combines the power of SUI with the camaraderie of the coolest crypto crew. Join our community for blockchain banter, crypto capers, and a unique blend of finance and fun. Embrace the fast transactions and faster laughs with Solanafellas, where every coin is a ticket to the future and every moment is a ride with the ultimate gang!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiffellas_e9afd2b5d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFFELLAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFFELLAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

