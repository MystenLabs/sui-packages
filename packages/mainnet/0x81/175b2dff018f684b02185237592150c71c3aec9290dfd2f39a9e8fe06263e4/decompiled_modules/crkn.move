module 0x81175b2dff018f684b02185237592150c71c3aec9290dfd2f39a9e8fe06263e4::crkn {
    struct CRKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRKN>(arg0, 9, b"CRKN", b"Cracken", b"Ocean giant octopas new era of ocean king meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7908f927-5204-44a9-9dae-081a82c041fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

