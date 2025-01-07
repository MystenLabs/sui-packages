module 0x96a4fcd08159c44e9dcf8ef51d7fa23bd41cdfc08afccd406ebcb1e7d29e41ab::nimbus {
    struct NIMBUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIMBUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIMBUS>(arg0, 9, b"Nimbus", b"Nimbus Cat", b"Nimbus zoomies overload", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1848114430237630464/5Cs7XLvE_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NIMBUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIMBUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIMBUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

