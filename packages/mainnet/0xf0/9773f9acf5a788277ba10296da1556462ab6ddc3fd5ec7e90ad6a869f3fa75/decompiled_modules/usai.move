module 0xf09773f9acf5a788277ba10296da1556462ab6ddc3fd5ec7e90ad6a869f3fa75::usai {
    struct USAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<USAI>(arg0, 6, b"USAI", b"UsAI  by SuiAI", b"UsAI is your intelligent social media companion, designed to revolutionize the way you interact and engage on platforms like Twitter. Powered by advanced AI, UsAI automates, personalizes, and optimizes your social media experience, offering smart content creation, real-time interaction, and data-driven insights. Whether you're a business, influencer, or casual user, UsAI is here to enhance your digital presence and maximize your impact. With a fair launch model, UsAI ensures equal opportunity for all, making it a powerful tool for the next era of social media", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_8dbb50f9da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

