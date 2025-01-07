module 0x604f67d54c5f4ce520b4f354ff1ba8d07c56ab7b36fff0b1fc9835c7a89027f8::turboscat {
    struct TURBOSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSCAT>(arg0, 6, b"TURBOSCAT", b"Turbos CAT", b"First cat on Turbos Fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984196554.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

