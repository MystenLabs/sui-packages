module 0x86389ddc7b6389bdd5c2e349c9f6510a6715988cdbf05b3a844c33e2e7ca8cd9::vro {
    struct VRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VRO>(arg0, 6, b"VRO", b"vro", b"hello vro ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_103830_204_fa956da120.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

