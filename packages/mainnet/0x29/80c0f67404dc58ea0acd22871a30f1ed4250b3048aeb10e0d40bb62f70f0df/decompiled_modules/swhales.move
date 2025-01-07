module 0x2980c0f67404dc58ea0acd22871a30f1ed4250b3048aeb10e0d40bb62f70f0df::swhales {
    struct SWHALES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWHALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWHALES>(arg0, 6, b"Swhales", b"SuiWhales", b"Biggest whale on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000369_facd03f43f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWHALES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWHALES>>(v1);
    }

    // decompiled from Move bytecode v6
}

