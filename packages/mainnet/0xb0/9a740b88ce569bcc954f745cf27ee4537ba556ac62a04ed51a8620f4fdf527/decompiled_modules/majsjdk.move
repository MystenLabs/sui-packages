module 0xb09a740b88ce569bcc954f745cf27ee4537ba556ac62a04ed51a8620f4fdf527::majsjdk {
    struct MAJSJDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJSJDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJSJDK>(arg0, 9, b"MAJSJDK", b"Nsyjsm", b"Ydjfkd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/795b342f-0fbc-4704-9aa7-f56b094e6ba7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJSJDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAJSJDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

