module 0x894de82007ceb7486a475cc1104032710b08da14a6acc0b0b06913382b4e4559::balaji {
    struct BALAJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALAJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALAJI>(arg0, 9, b"BALAJI", b"Salasar", b"Salasar Balaji Temple Charitable Trust ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/104de051-b80f-47fc-bf21-2d2d9e83ed15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALAJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALAJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

