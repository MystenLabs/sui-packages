module 0xa2dff49990a3d9aa06616a0a7cce51a799b89ae0ece528acd046741db3addaa4::len {
    struct LEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEN>(arg0, 9, b"LEN", b"Len Sessaman", b"Len Sessaman Deploy BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/QmV19uysquHKiGj8EH2vGSrjT5YYQDCYyykw1sArju2sTJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LEN>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

