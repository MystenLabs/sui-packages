module 0x2fad35b15a09cc2d9d1cd05fa19b8d72c538975e81c1aa6852e5eb8056acb08e::smurf {
    struct SMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURF>(arg0, 6, b"SMURF", b"SUI SMURF", b"Sui Smurf is the perfect bringing a new wave of excitement to the crypto space. Sui Smurf combines charm, humor, and community spirit to create a unique memecoin experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d7ka05_US_400x400_5bf6f9b781.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

