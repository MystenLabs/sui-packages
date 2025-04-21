module 0xec5250e9f50e65975d84cb7f34e27d20baad4ef31de76c570ca599d9711d23a6::TUNG {
    struct TUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNG>(arg0, 6, b"TUNG", b"tung tung tung sahur", b"Tung tung tung tung tung tung tung tung tung sahur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmVuUveGi1xUqNsokSWrr6gVSXVRpATJ73RKg2Sba4BmPt")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

