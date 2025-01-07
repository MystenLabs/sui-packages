module 0x4a7d4063aa3299688a043f62ce30a32bcb77bb2ac9def1b66c3715be35af811f::pengi {
    struct PENGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGI>(arg0, 9, b"Pengi", b"Pudgy Pengi", x"436f6d6d756e697479204f776e65642050656e6775696e73212121204e657665722064756d706564206279205643202470656e67750a0a4c464721212057474d4921210a0a464f434b494e4720544845202450454e4755205445414d2c20544845592044554d50204f4e20555321210a0a544845204b494e47202450454e4749", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmSbpKtdvNXtQkutFaiB7eawXniVVTgWSonzxrn6yYbsCS")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENGI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

