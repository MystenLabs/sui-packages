module 0x3c29dbaaadcbcd976c588d86be60cae0fba053c33132e36dac08ccebcf689ef::selena {
    struct SELENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELENA>(arg0, 9, b"SELENA", b"Selenagome", b"launch of the official token Selenagomez", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9edae28-2f64-4bd6-adc0-83dce649edab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SELENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

