module 0xd95aed199ac0dd8b8ba5b503bd44e74a25a7406efff47abf2805b6f5a96eb0b8::shibe {
    struct SHIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHIBE>(arg0, 6, b"SHIBE", b"SuiShibe by SuiAI", b"SuiShibe is a community-driven meme token built on the Sui Network, combining the beloved Shiba Inu meme culture with innovative blockchain technology. Our mission is to create a fun, engaging ecosystem where memes meet utility. Through our Meme Mission platform, we empower users to earn rewards while participating in community activities and governance. Join us in building the most vibrant and entertaining community in the Sui ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_f36ec60d09.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIBE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

