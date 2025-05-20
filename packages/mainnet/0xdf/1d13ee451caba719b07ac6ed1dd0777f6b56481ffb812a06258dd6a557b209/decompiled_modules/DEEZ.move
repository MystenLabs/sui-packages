module 0xdf1d13ee451caba719b07ac6ed1dd0777f6b56481ffb812a06258dd6a557b209::DEEZ {
    struct DEEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEZ>(arg0, 6, b"DEEZ", b"Deez nuts", b"deeeezzzzz nutssssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmV1h9u9mrP7SeKPJQxQCJnx1f8jQMx7hxy9dQiNQqy8oG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

