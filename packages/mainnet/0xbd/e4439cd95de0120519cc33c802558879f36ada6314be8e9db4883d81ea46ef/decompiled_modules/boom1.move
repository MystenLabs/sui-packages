module 0xbde4439cd95de0120519cc33c802558879f36ada6314be8e9db4883d81ea46ef::boom1 {
    struct BOOM1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM1>(arg0, 9, b"BOOM1", b"boom1", b"boom1boom1boom1boom1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

