module 0x402655a4801f55d83de330655dcda7e40c53da5ced39a33e97a668d3f09ba8ac::rakki {
    struct RAKKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKKI>(arg0, 6, b"Rakki", b"Rakki on sui", b"RAKKI on SUI - The lucky cat, now meowing on SUI blockchain Lets do memes together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t1wpq6bw_400x400_2409786717.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAKKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

