module 0x1233fb2654f51a55ec554e7ebb8903bb7528311c029b6f51fcdd7c2af23ed82d::hopfun {
    struct HOPFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFUN>(arg0, 6, b"HopFun", b"HopFunCTO", b"Hop delayed too much and the community decided to take over and launch Hop Fun CTO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016718_2a571c8f41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

