module 0xb7c70874bea24c2a7b00e3237a471d7f1cfea9a1f37332056528057e6222de67::catsdog {
    struct CATSDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSDOG>(arg0, 9, b"CATSDOG", b"Catdog", b"Boost your fundz for 50x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2939186-d2f7-486d-9f67-2aef6f39a0b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

