module 0x1f2f34ff629ac3dad1be167db3ca5a9b6e12821fee97d387144bf3ad2b145219::tommyrobinsonxtrump {
    struct TOMMYROBINSONXTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMMYROBINSONXTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMMYROBINSONXTRUMP>(arg0, 9, b"Tommy Robinson x TRUMP", b"SAVEUKUS", b"Save UK and the USA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758882843/sui_tokens/mj43mkldxrbagyitp7eu.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TOMMYROBINSONXTRUMP>>(0x2::coin::mint<TOMMYROBINSONXTRUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOMMYROBINSONXTRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOMMYROBINSONXTRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

