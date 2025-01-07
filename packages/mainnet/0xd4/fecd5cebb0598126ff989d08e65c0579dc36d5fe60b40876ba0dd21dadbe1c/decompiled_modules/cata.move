module 0xd4fecd5cebb0598126ff989d08e65c0579dc36d5fe60b40876ba0dd21dadbe1c::cata {
    struct CATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATA>(arg0, 9, b"CATA", b"CatAi", b"0xc51ec44bd909c291dea18c6a5d3c3a2cbc1a04f0174c36be274439226e8c2175", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f6fbf07-034e-4423-8fd0-a4deb18a983e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

