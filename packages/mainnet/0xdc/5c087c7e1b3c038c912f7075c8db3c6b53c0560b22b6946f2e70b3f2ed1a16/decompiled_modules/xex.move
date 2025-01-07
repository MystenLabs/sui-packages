module 0xdc5c087c7e1b3c038c912f7075c8db3c6b53c0560b22b6946f2e70b3f2ed1a16::xex {
    struct XEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEX>(arg0, 9, b"XEX", b"Rex", b"Esd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48b97a10-6ab4-42b8-a945-337643ecf4ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

