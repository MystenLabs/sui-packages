module 0xca0dad9ca614f1e35886df90c1db2a6deb09c2f8a29cd2ba9ce38e2070483703::btlc {
    struct BTLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTLC>(arg0, 9, b"BTLC", b"BattleCoin", b"COIN FOR WIN THE BATTLEFIELD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3d43147-a95a-45c6-965a-478abd88fabe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

