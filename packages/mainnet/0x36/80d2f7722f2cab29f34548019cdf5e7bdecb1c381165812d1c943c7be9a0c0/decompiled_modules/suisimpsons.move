module 0x3680d2f7722f2cab29f34548019cdf5e7bdecb1c381165812d1c943c7be9a0c0::suisimpsons {
    struct SUISIMPSONS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISIMPSONS>, arg1: 0x2::coin::Coin<SUISIMPSONS>) {
        0x2::coin::burn<SUISIMPSONS>(arg0, arg1);
    }

    fun init(arg0: SUISIMPSONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISIMPSONS>(arg0, 6, b"SIMPSONS", b"Sui Simpsons", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/j8dfwDy/simpsons.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISIMPSONS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISIMPSONS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISIMPSONS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISIMPSONS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

