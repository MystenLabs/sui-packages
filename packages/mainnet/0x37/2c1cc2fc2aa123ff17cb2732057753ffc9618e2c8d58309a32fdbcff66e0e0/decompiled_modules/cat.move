module 0x372c1cc2fc2aa123ff17cb2732057753ffc9618e2c8d58309a32fdbcff66e0e0::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"CAT", b"CAT", b"Cat on the Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x6894cde390a3f51155ea41ed24a33a4827d3063d.png?size=lg&key=c82126")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

