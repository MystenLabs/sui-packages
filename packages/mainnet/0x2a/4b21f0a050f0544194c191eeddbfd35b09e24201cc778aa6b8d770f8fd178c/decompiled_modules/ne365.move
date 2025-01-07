module 0x2a4b21f0a050f0544194c191eeddbfd35b09e24201cc778aa6b8d770f8fd178c::ne365 {
    struct NE365 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NE365, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NE365>(arg0, 9, b"NE365", b"Never E365", b"Community fun token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dab57422-8233-42d0-8b60-041a31c1e3c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NE365>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NE365>>(v1);
    }

    // decompiled from Move bytecode v6
}

