module 0x78b3bd8011b053629c12cf762cc762d51aa95f4e0a63b22cf6d38319b360ad84::ienne {
    struct IENNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IENNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IENNE>(arg0, 9, b"IENNE", b"hebdb", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5dc77e2b-5b21-471f-a867-770779d12384.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IENNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IENNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

