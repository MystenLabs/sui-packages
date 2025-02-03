module 0xcc5f441c1fd7d42d98b3b5dbd01c08daa70d8df58ef12450b312d678cfa8d422::amy {
    struct AMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMY>(arg0, 9, b"AMY", b"Amiryasm", b"Amlljhk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/203fc80d-c4bd-4f99-84d3-232757fa2fc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

