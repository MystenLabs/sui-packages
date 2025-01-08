module 0x79d05fd77845d207465bd8ebe8ba99a17de6da1af2a5b792878f62f6896a648f::vft {
    struct VFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VFT>(arg0, 6, b"VFT", b"Vesse Food Tracker by SuiAI", b"Vesse Food Tracker is an AI-powered platform that allows users to upload images of their meals and receive detailed nutritional breakdowns, including protein, carbs, fiber, and fat content. With the help of advanced image recognition and AI analysis, the app delivers quick and accurate results to help you track your daily intake. Additionally, users can upload and share their favorite recipes, building a community of food enthusiasts who can explore new meal ideas while staying on top of their nutrition. Currently integrated with SUI AI technology and awaiting bonding with Turbos.finance, Vesse Food Tracker is set to revolutionize the way people track their food and nutrition.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Component_66_6cce311852.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

