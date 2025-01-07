module 0x58bf4a2dafad63304e2efb84bef6609674fa11465c926cc21ad21ab38022bfd4::stiwn {
    struct STIWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STIWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STIWN>(arg0, 9, b"STIWN", b"SongToanme", b"Go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7fc70b1-39a1-41d2-9550-11388991cd16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STIWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STIWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

