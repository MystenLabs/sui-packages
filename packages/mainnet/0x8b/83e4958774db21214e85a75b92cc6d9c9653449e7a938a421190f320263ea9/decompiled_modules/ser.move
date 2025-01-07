module 0x8b83e4958774db21214e85a75b92cc6d9c9653449e7a938a421190f320263ea9::ser {
    struct SER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SER>(arg0, 6, b"SER", b"Wen Marketing", x"496e74726f647563696e672024534552202d2057656e204d61726b6574696e670a5468652066697273742d657665722063727970746f63757272656e63792070726f6a6563742064657369676e656420746f206578706f736520616e64207269646963756c65207468652066616b65206d61726b6574696e67206879706520696e207468652063727970746f20737061636521205765e280997265206865726520746f2063616c6c206f757420616c6c2074686f736520e2809c6775727573e2809d20616e6420e2809c65787065727473e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735931922964.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

