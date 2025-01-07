module 0x43f4cc56b69a33a9639e9d42cb976c6f79220ae90dd60a0ec23e01cd4855dd59::naturewow {
    struct NATUREWOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NATUREWOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NATUREWOW>(arg0, 9, b"NATUREWOW", b"Naturebeau", b"Nature is wow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66117db4-cb7f-4686-96c1-f5a4acaa1d80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NATUREWOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NATUREWOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

