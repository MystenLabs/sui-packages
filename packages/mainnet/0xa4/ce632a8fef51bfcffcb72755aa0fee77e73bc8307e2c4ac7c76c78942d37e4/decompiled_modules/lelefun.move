module 0xa4ce632a8fef51bfcffcb72755aa0fee77e73bc8307e2c4ac7c76c78942d37e4::lelefun {
    struct LELEFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LELEFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LELEFUN>(arg0, 9, b"LELEFUN", b"LeLe", b"Lele is funy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6ca079f-8c02-4e88-af66-74d86bfdcc9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LELEFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LELEFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

