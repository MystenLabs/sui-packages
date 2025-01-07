module 0xf07d0ce938e5ff8c74e521d92a51e2f7f90a274bdaab25e0c316b900a982f356::satkhira {
    struct SATKHIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATKHIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATKHIRA>(arg0, 9, b"SATKHIRA", b"HASAN", b"Inspired from wave wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa6dbbba-384d-48e1-801a-4693d1a43a26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATKHIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATKHIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

