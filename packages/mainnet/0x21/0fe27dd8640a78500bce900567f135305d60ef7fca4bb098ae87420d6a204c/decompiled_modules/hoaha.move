module 0x210fe27dd8640a78500bce900567f135305d60ef7fca4bb098ae87420d6a204c::hoaha {
    struct HOAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOAHA>(arg0, 9, b"HOAHA", b"atutu", b"atutu is a coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/434ae85d-6ae5-45b5-842c-49d6c5fd24cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

