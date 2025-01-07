module 0x84be9aedcd5e42753a6422ea6c52e542b24d5305fe9d139c953ca7fd22c587a1::rootlets {
    struct ROOTLETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOTLETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOTLETS>(arg0, 6, b"Rootlets", b"Rootlets onSui", b"https://x.com/rootlets_nft/status/1838598788593934665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYQ_Dk55ak_AINV_4_bf1fd8b8fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOTLETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOTLETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

