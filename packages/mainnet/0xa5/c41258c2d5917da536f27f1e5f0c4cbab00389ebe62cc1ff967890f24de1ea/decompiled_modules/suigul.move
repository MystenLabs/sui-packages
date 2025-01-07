module 0xa5c41258c2d5917da536f27f1e5f0c4cbab00389ebe62cc1ff967890f24de1ea::suigul {
    struct SUIGUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUL>(arg0, 6, b"SUIGUL", b"THE GREAT SEAGUL OF SUI COASTS!", b"$SUIGUL is a soaring token on the Sui, inspired by the freedom of a seagull gliding over the Sui coast. Just like the seagull, $SUIGUL moves swiftly and explores new horizons in the crypto seas. Catch the winds of opportunity with the seagull of Suis coast!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIGUL_2a68952a26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

