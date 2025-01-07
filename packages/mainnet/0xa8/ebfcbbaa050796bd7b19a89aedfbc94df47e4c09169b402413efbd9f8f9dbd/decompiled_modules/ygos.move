module 0xa8ebfcbbaa050796bd7b19a89aedfbc94df47e4c09169b402413efbd9f8f9dbd::ygos {
    struct YGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YGOS>(arg0, 6, b"YGOS", b"YELLOW GROUPER ON SUI", x"5368696e6e696e672079656c6c6f772067726f7570686572206669736820696e207468652064656570206f6620737569206f6365616e206973207377696d20746f737572666163650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_Image_8suk0f8suk0f8suk_jpeg_aa6a89f6f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YGOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YGOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

