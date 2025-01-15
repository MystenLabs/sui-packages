module 0xf80e1b3d94ed29c9272d492f1d39ae6f56e19dc72d61e349b1e21126540af46d::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIC>(arg0, 6, b"ERIC", b"Eric Trump Buys $SUI", b"JUST IN: SON OF THE US PRESIDENT ELECT, ERIC TRUMP HOLD SUI IN HIS PERSONAL PORFOLIO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/erictrump_6930f61365.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

