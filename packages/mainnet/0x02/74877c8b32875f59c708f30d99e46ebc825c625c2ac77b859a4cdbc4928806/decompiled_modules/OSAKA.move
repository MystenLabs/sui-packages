module 0x274877c8b32875f59c708f30d99e46ebc825c625c2ac77b859a4cdbc4928806::OSAKA {
    struct OSAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAKA>(arg0, 9, b"OSAKA", b"Osaka Max Wynn", b"Osaka from Azu Manga Daioh - The Inspiration Behind Drake's Alter Ego Anita Max Wynn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746780667265064960/NhX-FbzO_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OSAKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OSAKA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

