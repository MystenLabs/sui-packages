module 0x9253f039e778d538e97d0b54e6865e7c068d668b3bcca7fedb1e6341b96430e9::cartel {
    struct CARTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTEL>(arg0, 6, b"CARTEL", b"Cartel on Sui", b"Join the war on SUI, fighting with CARTEL community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029205_e6a2b81b5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARTEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

