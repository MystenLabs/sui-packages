module 0x2ab70935041c63a557848758f644480573ec1fdbcf78fed7fc93e2b0f6507bd7::black {
    struct BLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACK>(arg0, 9, b"BLACK", b"Black Coin", b"I'm Black", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12119792-3c5e-44ec-b117-6cb39fa1b175.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

