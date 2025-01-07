module 0xfae772509a3c0160a77eac778d658f7deea638cd02d8da914f7d8667b8e43f25::DiviShare {
    struct DIVISHARE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DIVISHARE>, arg1: &mut 0x2::coin::Coin<DIVISHARE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::coin::burn<DIVISHARE>(arg0, 0x2::coin::split<DIVISHARE>(arg1, arg2, arg3))
    }

    public fun make_immutable(arg0: 0x2::package::UpgradeCap) {
        0x2::package::make_immutable(arg0);
    }

    fun init(arg0: DIVISHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DIVISHARE>(arg0, 4, b"DVS", b"DiviShare", b"DiviShare Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://7thlin4n6nehvi3olzmlz7q5rkygp3k7p3wnn4htjttzffynqamq.arweave.net/_M60N43zSHqjbl5YvP4dirBn7V9-7Nbw80znkpcNgBk"))), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIVISHARE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<DIVISHARE>>(0x2::coin::mint<DIVISHARE>(&mut v3, 1000000000000000, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVISHARE>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

