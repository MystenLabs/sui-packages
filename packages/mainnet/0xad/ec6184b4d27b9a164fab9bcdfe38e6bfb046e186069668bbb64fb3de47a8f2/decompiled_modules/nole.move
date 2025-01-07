module 0xadec6184b4d27b9a164fab9bcdfe38e6bfb046e186069668bbb64fb3de47a8f2::nole {
    struct NOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOLE>(arg0, 6, b"NOLE", b"Nole", b"A \"Nole meme\" might be crafted to get Musk's attention or to joke about the potential of Nole Coin skyrocketing in value due to a hypothetical Musk tweet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cn_Ywql_Lx_400x400_7fc31f0dfb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

