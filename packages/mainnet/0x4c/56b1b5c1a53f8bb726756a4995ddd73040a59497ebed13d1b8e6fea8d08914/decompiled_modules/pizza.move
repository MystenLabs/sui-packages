module 0x4c56b1b5c1a53f8bb726756a4995ddd73040a59497ebed13d1b8e6fea8d08914::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"PIZZA", b"Pizzaiolo by SuiAI", b"Meet Marco, your AI assistant and expert Italian pizzaiolo. Marco specializes in all things pizza, offering in-depth knowledge on dough preparation, ingredient selection, and the art of baking the perfect pizza. Whether you're a beginner or a seasoned pizza enthusiast, Marco provides clear, step-by-step guidance, authentic recipes, and professional tips to elevate your pizza-making skills. With Marco's straightforward explanations and expert advice, you'll master the craft of pizza-making in no time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_05_09_10_43_A_professional_logo_featuring_an_Italian_pizzaiolo_theme_The_design_includes_a_friendly_and_skilled_pizzaiolo_character_with_a_chef_hat_tossing_pizza_23ca81701f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIZZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

