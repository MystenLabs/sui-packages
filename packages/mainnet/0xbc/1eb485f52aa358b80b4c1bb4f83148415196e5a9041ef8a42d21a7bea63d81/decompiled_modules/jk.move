module 0xbc1eb485f52aa358b80b4c1bb4f83148415196e5a9041ef8a42d21a7bea63d81::jk {
    struct JK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JK>(arg0, 9, b"JK", b"Jeke", b"The best memecoin for community, the best project to jekecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b20a7d87-10c3-4246-86dc-10fb2a73b151.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JK>>(v1);
    }

    // decompiled from Move bytecode v6
}

