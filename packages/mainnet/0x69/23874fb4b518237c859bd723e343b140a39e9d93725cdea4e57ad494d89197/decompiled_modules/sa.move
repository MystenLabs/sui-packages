module 0x6923874fb4b518237c859bd723e343b140a39e9d93725cdea4e57ad494d89197::sa {
    struct SA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA>(arg0, 9, b"SA", b"SAnk", b"Punk ring a like", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3042ef2c-f336-4d63-8ada-5dd0b00f3277.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SA>>(v1);
    }

    // decompiled from Move bytecode v6
}

