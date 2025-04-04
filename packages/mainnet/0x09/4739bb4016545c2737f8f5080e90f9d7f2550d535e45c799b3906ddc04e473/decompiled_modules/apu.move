module 0x94739bb4016545c2737f8f5080e90f9d7f2550d535e45c799b3906ddc04e473::apu {
    struct APU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<APU>, arg1: 0x2::coin::Coin<APU>) {
        0x2::coin::burn<APU>(arg0, arg1);
    }

    fun init(arg0: APU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APU>(arg0, 9, b"Apu", b"APU", b"TLOGO APU APU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/p27hwhh/apuicon1-250x250.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<APU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<APU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

