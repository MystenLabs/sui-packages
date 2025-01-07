module 0xb3e33ce8035bf95cbc72dbba3ccc6b021cd89a6a990107be496577ddda779dae::hams {
    struct HAMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMS>(arg0, 6, b"HAMS", b"HAMSTER", b"Small Paws, Big Gains: Race to the Moon with $HAMS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_26_at_04_00_16_a259909ad0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

