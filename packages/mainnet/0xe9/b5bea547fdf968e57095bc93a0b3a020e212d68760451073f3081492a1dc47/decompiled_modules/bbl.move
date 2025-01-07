module 0xe9b5bea547fdf968e57095bc93a0b3a020e212d68760451073f3081492a1dc47::bbl {
    struct BBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBL>(arg0, 9, b"BBL", b"BABY BLUE ", b"THE BLUE CHILDREN ATTACKED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8d6fec7-d645-44d5-8207-f03390939ed1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

