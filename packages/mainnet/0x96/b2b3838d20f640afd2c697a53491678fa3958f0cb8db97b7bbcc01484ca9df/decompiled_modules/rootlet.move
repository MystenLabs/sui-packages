module 0x96b2b3838d20f640afd2c697a53491678fa3958f0cb8db97b7bbcc01484ca9df::rootlet {
    struct ROOTLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOTLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOTLET>(arg0, 6, b"ROOTLET", b"RootletonSui", b"https://x.com/rootlets_nft/status/1838598788593934665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYQ_Dk55ak_AINV_4_6a7be14893.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOTLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOTLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

