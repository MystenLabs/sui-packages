module 0x4bb86d27c7b2951be3cd9d8c64c5bebc0b435c5e3df12577346857131d48c294::finker {
    struct FINKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINKER>(arg0, 6, b"FINKER", b"Finker Sui", b"From underground comic scenes to crypto meme  dreams, Matt Furies iconic creation, Finker.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_18_at_16_05_00_58b6d7af4b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

