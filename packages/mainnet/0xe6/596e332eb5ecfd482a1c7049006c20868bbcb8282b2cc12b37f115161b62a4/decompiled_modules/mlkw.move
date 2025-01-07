module 0xe6596e332eb5ecfd482a1c7049006c20868bbcb8282b2cc12b37f115161b62a4::mlkw {
    struct MLKW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLKW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLKW>(arg0, 6, b"MLKW", b"MilkyWay", b"Staking hub for the modular ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mlkw_cb912564d6.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLKW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLKW>>(v1);
    }

    // decompiled from Move bytecode v6
}

