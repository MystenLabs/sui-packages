module 0xbd1490d3d3756e9ac5382c5e736c0c59155ef67d7c0493418a4ee16682627ef1::sbonk {
    struct SBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBONK>(arg0, 6, b"SBONK", b"SUIBONK", b"BONK ON SUICHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4247_d4b0a100df.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

