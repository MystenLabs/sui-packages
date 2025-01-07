module 0xfd60ad91bc18211786612cf3d9b6cde96515cf444fc4e86635dfede11458d84e::kay {
    struct KAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAY>(arg0, 9, b"KAY", b"Kayna ", b"Meant it when I said I will spark everything ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e8df7cf-544f-4575-958c-c07595de74cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

