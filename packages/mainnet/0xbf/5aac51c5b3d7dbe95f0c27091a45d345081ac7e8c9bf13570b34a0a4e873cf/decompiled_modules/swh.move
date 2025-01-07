module 0xbf5aac51c5b3d7dbe95f0c27091a45d345081ac7e8c9bf13570b34a0a4e873cf::swh {
    struct SWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWH>(arg0, 9, b"SWH", b"suiman wif hat", b"the suiman wif hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWH>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

