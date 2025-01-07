module 0xb921d7fedae2e97408deec490f1555c2dbc1726b01feea75f4088ebd8e46799c::and {
    struct AND has drop {
        dummy_field: bool,
    }

    fun init(arg0: AND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AND>(arg0, 9, b"AND", b"android", x"576964656c79207573656420616e642063686561700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e12a4c6-cec4-4d34-83c1-925b156fdcee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AND>>(v1);
    }

    // decompiled from Move bytecode v6
}

