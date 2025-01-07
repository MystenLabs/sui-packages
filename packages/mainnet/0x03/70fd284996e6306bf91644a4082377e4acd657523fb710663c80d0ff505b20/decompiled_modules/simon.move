module 0x370fd284996e6306bf91644a4082377e4acd657523fb710663c80d0ff505b20::simon {
    struct SIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMON>(arg0, 6, b"SIMON", b"Simone on SUI", b"USA Gymnast and 4 time gold medalist.  Coming back to her final Olympics in Paris 2024.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Itz_Ne_ZNR_400x400_279bf9dd35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

