module 0x654825e4865141808d902e223fe31fb27170d7cc066a7e0c4493cb65c66e7680::gbdp {
    struct GBDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBDP>(arg0, 9, b"GBDP", b"GBDP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/1owQhdz8mCjjgsSLoM0a7mGv_TZsE9AHUzHKGxzpKaM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GBDP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBDP>>(v2, @0x5bb998efe97284dce379470309aae37c3ed720e7c39a16fe99ca8b5a12e39c7f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

