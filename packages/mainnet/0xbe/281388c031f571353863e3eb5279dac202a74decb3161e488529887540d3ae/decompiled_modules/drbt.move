module 0xbe281388c031f571353863e3eb5279dac202a74decb3161e488529887540d3ae::drbt {
    struct DRBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRBT>(arg0, 9, b"DRBT", b"DEADROBOT", b"this robot is dead , this token is alive", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30b07c1b-cb3b-4688-b900-195c320edde1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

