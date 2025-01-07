module 0x9e7660945d847ed05b451fc7b5239c90ef48e25de36b925c7f632305e4a77132::fubb {
    struct FUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUBB>(arg0, 6, b"FUBB", b"Fubb Sui", b"Fubb is a tiny, curious creature who loves to hop around and explore new places", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/671630b50dbe571e29891a64_Whats_App_Image_2024_10_21_at_18_43_13_p_1080_766432f260.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

