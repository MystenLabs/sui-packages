module 0x53db4a895a837c0c5cb9d14c874d699c4eeb094b08968464f44131b29b5ff432::suitrump {
    struct SUITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMP>(arg0, 6, b"SUITRUMP", b"Sui Trump", b"SUI TRUMP Coin is a fan-based cryptocurrency built on the SUI blockchain, created to harness the passion and enthusiasm of Donald Trump supporters. Its designed to unite a politically active community and offer a unique way to engage with the 2024 U.S. presidential election and Trumps movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11zon_cropped_efb4cc14dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

