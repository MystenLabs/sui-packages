module 0xf91298b1d8e24e6833168729ef75f81bc35abc8881a01fce836515305c3b833::rck {
    struct RCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCK>(arg0, 9, b"RCK", b"Rocky", b"Rocky on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d15b0e61-24c3-49a7-9074-a7869ef6751c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

