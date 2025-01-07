module 0x9ab5bc1f9ac6c061f7d2859882d92bea20f5bb8380fbf5d1e63f6faaa25832e5::gdfv {
    struct GDFV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDFV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDFV>(arg0, 6, b"gdfv", b"gdfv", b"fssd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GDFV>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDFV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GDFV>>(v1);
    }

    // decompiled from Move bytecode v6
}

