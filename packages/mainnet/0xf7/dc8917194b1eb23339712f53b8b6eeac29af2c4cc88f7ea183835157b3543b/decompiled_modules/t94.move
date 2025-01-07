module 0xf7dc8917194b1eb23339712f53b8b6eeac29af2c4cc88f7ea183835157b3543b::t94 {
    struct T94 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T94, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T94>(arg0, 9, b"T94", b"Teri", b"mission to make humanity rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b81c814-c135-467d-b81b-693bfcce20ae-FB2F94C1-70E8-436A-A2A5-FC7DD337DA3D.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T94>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T94>>(v1);
    }

    // decompiled from Move bytecode v6
}

