module 0xf3161322b0c4d1e7f66a5b69ece8ef7e803362713bde5dd6499e1307f8d55bd2::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"cat", b"cat", b"cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipads.fun/api/files/suipump/logos/0x159ca760875b2e1713b7132559e0f50bc9e29a4e310816bc0683ab425ea814ce/7422e5fb-88fc-4bca-a475-08009915489e.jpeg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAT>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

