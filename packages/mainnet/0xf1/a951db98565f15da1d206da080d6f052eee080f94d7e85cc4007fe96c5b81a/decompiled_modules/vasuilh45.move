module 0xf1a951db98565f15da1d206da080d6f052eee080f94d7e85cc4007fe96c5b81a::vasuilh45 {
    struct VASUILH45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VASUILH45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VASUILH45>(arg0, 9, b"VASUILH45", b"Grod wave", b"Goood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fee24d83-4f66-45c5-9351-fa624386d936.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VASUILH45>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VASUILH45>>(v1);
    }

    // decompiled from Move bytecode v6
}

