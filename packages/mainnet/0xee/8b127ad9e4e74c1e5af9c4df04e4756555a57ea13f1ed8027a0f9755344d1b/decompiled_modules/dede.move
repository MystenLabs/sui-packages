module 0xee8b127ad9e4e74c1e5af9c4df04e4756555a57ea13f1ed8027a0f9755344d1b::dede {
    struct DEDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEDE>(arg0, 6, b"DEDE", b"Sui Dede", b"Dede is ready to conquer the waves of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_86_2d1964c0c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

