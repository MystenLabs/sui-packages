module 0xaf0bde982abedd335c7e27a28a6d16a281822fa30e3373f1dd5dce67412d0944::cornhb {
    struct CORNHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORNHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORNHB>(arg0, 6, b"CORNHB", b"CORNHUB", b"Feeling horn... I mean corny buy CORNHUB token and ride that thing to the mountain top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_12_065159_60e7787c34.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORNHB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORNHB>>(v1);
    }

    // decompiled from Move bytecode v6
}

