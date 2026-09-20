module 0x92e5f98f57e865e23e21a7dbcf9a992675a829e3712cfa99029be9c989c79024::afm {
    struct AFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFM>(arg0, 6, b"AFM", b"AFM_LP", b"SUI receipt token representing a share of the AM_FEATURE perpetuals vault.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

