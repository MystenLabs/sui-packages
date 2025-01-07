module 0x65640e70074a7c722da6ac1ecd9cb8aa135a54b4b557201dce200b05dc8290ab::pichui {
    struct PICHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICHUI>(arg0, 6, b"PICHUI", b"Pichui", b"Pichui Was Made To Be On Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_02_at_3_31_44_PM_1fd9765564.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

