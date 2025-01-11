module 0x5e9d7cc6a2f190b07295da084868097fe4abd4485a033655d51e69e860631616::akasui {
    struct AKASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKASUI>(arg0, 9, b"Akasui", b"AKASUI", b"SUI of Akasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/20947.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AKASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AKASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

