module 0x98717f45e9e2c659a57c10a81e986234ca004bb2b165b8ce3a553280356f4216::rabsui {
    struct RABSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABSUI>(arg0, 6, b"RABSUI", b"Rabbit Sui", b"We'll go to the moon with the lucky Rabbit on our sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_15_011622_debf97c12c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

