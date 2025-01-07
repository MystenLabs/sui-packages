module 0x87752ff54666a7dcb48f069c07905681860a24c668e3b42f80746331299e868e::otwn {
    struct OTWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTWN>(arg0, 9, b"OTWN", b"OLD TOWN", b"OLD TOWN  COIN , FULL OF HISTORY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4fdf7fa-7919-4a12-8fd2-13074ed7e7c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

