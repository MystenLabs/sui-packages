module 0xc50fa736c55e691ba9778c7e3716cb3034dde7cbc789a644c247f26a8a2ca9c6::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 6, b"WAVE", b"SUIWAVE", x"53757266696e6720746865205375692068797065212043617463682074686520686f74746573742077617665206f6e20537569210a53554957415645202824574156452920697320746865206d656d65636f696e20746861742072696465732074686520636f6d6d756e697479206879706520616e64206272696e677320667265736820656e6572677920746f207468652053756920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754683194365.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

