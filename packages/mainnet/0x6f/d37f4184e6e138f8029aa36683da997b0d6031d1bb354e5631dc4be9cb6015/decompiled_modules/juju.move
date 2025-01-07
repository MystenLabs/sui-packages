module 0x6fd37f4184e6e138f8029aa36683da997b0d6031d1bb354e5631dc4be9cb6015::juju {
    struct JUJU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUJU>(arg0, 9, b"JUJU", b"juliju", b"meme token for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c980ca0-2864-4ee3-8f96-c6b7a0125b54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUJU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUJU>>(v1);
    }

    // decompiled from Move bytecode v6
}

