module 0x9bf141edb44383552dba0827d06cd55c8ebbdaf474af535f1578454e8b84258::oepepe {
    struct OEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEPEPE>(arg0, 6, b"OEPEPE", b"One-eyed PEPE", x"4f6e652d457965642050657065207468652066726f672c2066726f6d20616c6c20636f726e657273206f6620746865206469676974616c207265616c6d20676174686572656420746f207769746e65737320686973206172726976616c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241223_232459_047_402d15d747.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OEPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

