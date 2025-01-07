module 0x77833f6693af7fb8a5b97ca8c94fbc4ad281d629e72715dee2b74b35f10f5169::rk {
    struct RK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RK>(arg0, 9, b"RK", b"Spent my l", x"4920646f6ee2809974206b6e6f77207768617420796f75206172652074616c6b696e6720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe12b50b-1721-4cf4-9a3c-928d4935c956.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RK>>(v1);
    }

    // decompiled from Move bytecode v6
}

