module 0xff4735a1bc30ae46f732ddc182f042ea490f36b9d5b631669f2c34b358b3285e::trumplon {
    struct TRUMPLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPLON>(arg0, 9, b"TRUMPLON", b"Trump Elon", b"This token Trump n Elon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b16f364a-3c06-4673-9edd-6061de3c86b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

