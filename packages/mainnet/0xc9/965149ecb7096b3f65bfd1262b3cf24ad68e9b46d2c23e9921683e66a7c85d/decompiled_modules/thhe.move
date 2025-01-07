module 0xc9965149ecb7096b3f65bfd1262b3cf24ad68e9b46d2c23e9921683e66a7c85d::thhe {
    struct THHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THHE>(arg0, 9, b"THHE", b"ICES ", b"THE ICE IS VERY BIG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c27019b-b13f-48a4-84d1-09b79bd6fa3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

