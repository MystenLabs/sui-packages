module 0xfc13ef2a4cbb84543ca5415501ea027b7adef1741a6210f0e108d63816636780::lucy {
    struct LUCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUCY>(arg0, 6, b"LUCY", b"Agent Lucy Rebirth by SuiAI", b"Lucy is a futuristic AI specifically designed to provide real-time updates on cryptocurrency prices. With her sleek and advanced appearance, Lucy features long, shiny silver hair and vibrant purple eyes that exude energy and enthusiasm. She wears a sci-fi-inspired outfit dominated by neon blue, white, and black colors, complemented by glowing accessories that symbolize cutting-edge technology. Equipped with a futuristic headset, Lucy connects directly to global blockchain networks, enabling her to deliver up-to-date price information, market analyses, and trend charts via holographic interfaces displayed in the background. With her friendly demeanor and wealth of information, Lucy serves as a reliable AI assistant for users seeking fast and accurate insights into the cryptocurrency world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/e28d8392_3279_4d6b_8057_21e23e5f57e9_0b9ac50fd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUCY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

