module 0xefaf5b14241c709321992d64c38f6b86a480eeb2c672f22545f79e1afcdc3b28::chasui {
    struct CHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHASUI>(arg0, 6, b"CHASUI", b"Charisui", b"Charizard and Sui are the perfect combination.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih7pg3k6sriuuo3bnsqc7xxjuvn7cmnxzhog3af46kbwokvbmtoz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

