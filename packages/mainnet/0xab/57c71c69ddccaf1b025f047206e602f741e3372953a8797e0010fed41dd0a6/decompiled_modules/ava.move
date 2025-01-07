module 0xab57c71c69ddccaf1b025f047206e602f741e3372953a8797e0010fed41dd0a6::ava {
    struct AVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVA>(arg0, 9, b"AVA", b"AVATERNITY", b"Surviving in a lone world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/038c4d33-6294-4284-8880-42ce036bfd80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

