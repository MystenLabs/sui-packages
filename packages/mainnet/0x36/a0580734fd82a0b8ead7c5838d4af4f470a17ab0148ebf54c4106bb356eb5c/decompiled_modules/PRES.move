module 0x36a0580734fd82a0b8ead7c5838d4af4f470a17ab0148ebf54c4106bb356eb5c::PRES {
    struct PRES has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PRES>, arg1: 0x2::coin::Coin<PRES>) {
        0x2::coin::burn<PRES>(arg0, arg1);
    }

    public entry fun sender(arg0: &mut 0x2::coin::TreasuryCap<PRES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PRES>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PRES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRES>(arg0, 9, b"PRES", b"PRES COIN", b"PRES COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/bc2t1Hx.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

