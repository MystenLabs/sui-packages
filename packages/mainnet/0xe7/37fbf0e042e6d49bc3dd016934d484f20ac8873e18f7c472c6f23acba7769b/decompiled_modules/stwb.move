module 0xe737fbf0e042e6d49bc3dd016934d484f20ac8873e18f7c472c6f23acba7769b::stwb {
    struct STWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STWB>(arg0, 9, b"STWB", b"Strawberry", b"Life is short, eat dessert first (and invest in Strawberry Dessert)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88a80b02-9f78-45bb-8290-5b65f3bef156.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STWB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

