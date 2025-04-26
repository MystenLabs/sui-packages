module 0x99c500d5eb9ee4e9346088c4098279e8ed8b6630bf2ddb2f6c070b4d34080519::bzala {
    struct BZALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZALA>(arg0, 9, b"BZALA", b"BABY ZALA", x"42616279205a616c612069736e74206a7573742061206e657720666163652020736865732074686520666163652e0d0a426f726e2066726f6d206368616f732c206275696c7420746f207472656e642c20776972656420746f2077696e2e0d0a53686520646f65736e2774206361726520696620796f752772652072656164792e20536865206d6f7665732066697273742c20796f7520666f6c6c6f77206c617465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSyBSDxSQMqC1zYk9Fs5pKd2wjMy4ese96TZzvm93RVmy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BZALA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BZALA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZALA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

