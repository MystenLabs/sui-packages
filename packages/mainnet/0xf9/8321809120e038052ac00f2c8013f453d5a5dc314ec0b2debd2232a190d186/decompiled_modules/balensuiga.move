module 0xf98321809120e038052ac00f2c8013f453d5a5dc314ec0b2debd2232a190d186::balensuiga {
    struct BALENSUIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALENSUIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALENSUIGA>(arg0, 6, b"Balensuiga", b"Balenciaga on Sui", b"Balanciage on movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RTTBTB_01c29b96eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALENSUIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALENSUIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

