module 0x8f36cb236b4346cec91bba469d95b8c6f19c43877c48229856c7d7471a7218a5::mkt {
    struct MKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKT>(arg0, 9, b"MKT", b"Monkey Smart", b"Monkey Smart Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/b563fd2fbe3d5b1ab268451a9d1a5042636ed44a94446aeb70c358f079bba17f?width=64&height=64&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MKT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

