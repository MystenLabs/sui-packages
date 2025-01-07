module 0x859fe2a413b8a2b28ce247583e3290d9913f52644c36f32ae12bda46927028af::dka {
    struct DKA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DKA>, arg1: 0x2::coin::Coin<DKA>) {
        0x2::coin::burn<DKA>(arg0, arg1);
    }

    fun init(arg0: DKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKA>(arg0, 9, b"dka", b"dka", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiscan.xyz/static/media/suiCoinLogo.b3b77ca65ac4f170e7e075732ea93352.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKA>>(v1);
        0x2::coin::mint_and_transfer<DKA>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DKA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

