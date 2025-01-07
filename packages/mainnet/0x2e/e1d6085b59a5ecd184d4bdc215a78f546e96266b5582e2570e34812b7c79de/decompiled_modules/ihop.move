module 0x2ee1d6085b59a5ecd184d4bdc215a78f546e96266b5582e2570e34812b7c79de::ihop {
    struct IHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IHOP>(arg0, 6, b"IHOP", b"IHop", x"49486f70207c20486f7070696e6720746f776172647320647265616d732077697468206120746f756368206f6620686f706520616e6420612064617368206f66206d697363686965662120f09f90b0e29ca820526561647920746f20626f756e636520746f20746865206d6f6f6e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956787148.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IHOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IHOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

