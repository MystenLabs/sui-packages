module 0xfd79b0bb0b053f8e858bceca6b5bb6560067f79787d919979e50e2669c6b437c::ducke {
    struct DUCKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKE>(arg0, 6, b"Ducke", b"Ducks Sui", b"Ducke Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif7gwdbczeelm4to3ewnhoipqlxac52zlmpojeloqjtgvozuez4v4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUCKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

