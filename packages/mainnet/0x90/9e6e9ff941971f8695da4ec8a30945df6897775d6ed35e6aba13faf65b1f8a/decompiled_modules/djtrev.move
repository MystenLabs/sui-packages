module 0x909e6e9ff941971f8695da4ec8a30945df6897775d6ed35e6aba13faf65b1f8a::djtrev {
    struct DJTREV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJTREV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJTREV>(arg0, 6, b"DJTREV", b"DonaldJamesTulsiRobertElonVivek", b"Meet DJ Trev, DonaldJamesTulsiRobertElonVivek dropping the hottest tracks on Sui. Be on the lookout for all the Remix tracks going live. Links going live with Dex Screener after bonding. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9609_5870e5bc08.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJTREV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJTREV>>(v1);
    }

    // decompiled from Move bytecode v6
}

