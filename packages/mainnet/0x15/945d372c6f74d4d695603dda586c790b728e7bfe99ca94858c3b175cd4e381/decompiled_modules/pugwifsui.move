module 0x15945d372c6f74d4d695603dda586c790b728e7bfe99ca94858c3b175cd4e381::pugwifsui {
    struct PUGWIFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWIFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWIFSUI>(arg0, 6, b"PUGWIFSUI", b"PUGWIFHAT", b"Resurging from the ashes of a premature rug, arose the pug that doesn't quit. His message is clear: he won't stand for scams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_020555138_b466598e3b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWIFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWIFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

