module 0xc7b57cf66e4512a30a2d8972f5ee0cc0b087fcb262c8e76dfb5969c5ce45dcfd::hamir {
    struct HAMIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMIR>(arg0, 6, b"HAMIR", b"HAMIRU", b"HAMIRU is a revolutionary cryptocurrency token built on the Sui Blockchain, symbolizing agility, cunning, and adaptability, inspired by the majestic red fox. Designed to empower decentralized applications (dApps) and foster community engagement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1e00e52d_f024_4db9_81db_129560b6b967_648e63e5c2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

