module 0xb99b127a93979f8b80138e26d9134005feda3b7bef0bc5be1721ea11f9934c44::jt {
    struct JT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JT>(arg0, 9, b"JT", b"JETT", b"Jett Valorant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b75451f-45dc-443f-8567-e1748a5a7ba8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JT>>(v1);
    }

    // decompiled from Move bytecode v6
}

