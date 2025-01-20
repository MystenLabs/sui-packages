module 0x21b9545a843c8210d3d9c05ff59ca02a49a61a1923d0c8ddd18d48bd601cec45::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"MELANIA AI by SuiAI", b"Introducing Melania AI.The ultimate Official memecoin inspired by the elegance and sophistication of Melania Trump. Powered by the Sui Network, Melania AI combines cutting-edge technology with the allure of the Trump family's matriarch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/473564065_623193606788161_1055950694228575587_n_1c1b9417b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

