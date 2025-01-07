module 0xa3fc35654a3fecc3a36610560b653090e24d51896c8bb43d18339a289817d86f::ozn {
    struct OZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZN>(arg0, 9, b"OZN", b"Ozean", b"Ozeann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c72af63-84f4-464a-82ca-6cadf0413056.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OZN>>(v1);
    }

    // decompiled from Move bytecode v6
}

