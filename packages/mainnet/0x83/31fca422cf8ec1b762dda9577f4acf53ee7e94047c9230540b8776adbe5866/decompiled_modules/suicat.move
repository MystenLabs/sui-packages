module 0x8331fca422cf8ec1b762dda9577f4acf53ee7e94047c9230540b8776adbe5866::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"Sui Cat", x"4d65657420245355494341542c20746865206d6f7374206d697363686965766f75732066656c696e652070726f776c696e67207468652053756920626c6f636b636861696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_08_at_19_15_41_ad6f77de0e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

