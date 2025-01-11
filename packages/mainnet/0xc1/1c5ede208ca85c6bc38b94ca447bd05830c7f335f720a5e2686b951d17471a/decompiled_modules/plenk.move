module 0xc11c5ede208ca85c6bc38b94ca447bd05830c7f335f720a5e2686b951d17471a::plenk {
    struct PLENK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLENK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLENK>(arg0, 6, b"PLENK", b"SuiPlenk", b"AAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHh.sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0b9b48b0_f4a6_4ab0_a152_fea9682db537_e4dc8ea9e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLENK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLENK>>(v1);
    }

    // decompiled from Move bytecode v6
}

