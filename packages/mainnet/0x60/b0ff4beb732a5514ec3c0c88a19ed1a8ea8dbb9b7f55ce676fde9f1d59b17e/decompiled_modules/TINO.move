module 0x60b0ff4beb732a5514ec3c0c88a19ed1a8ea8dbb9b7f55ce676fde9f1d59b17e::TINO {
    struct TINO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TINO>, arg1: 0x2::coin::Coin<TINO>) {
        0x2::coin::burn<TINO>(arg0, arg1);
    }

    fun init(arg0: TINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINO>(arg0, 9, b"TINO", b"Tino", b"Ryan Coin Demo Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/WsZKdp9/tino.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TINO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TINO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

