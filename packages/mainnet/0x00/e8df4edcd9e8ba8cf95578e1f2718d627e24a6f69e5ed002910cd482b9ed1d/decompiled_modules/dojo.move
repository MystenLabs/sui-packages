module 0xe8df4edcd9e8ba8cf95578e1f2718d627e24a6f69e5ed002910cd482b9ed1d::dojo {
    struct DOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOJO>(arg0, 9, b"DOJO", b"Dojo", b"DOJO to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1833503430331060224/a5Wjd1GG.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOJO>(&mut v2, 70000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOJO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

