module 0x7c7b1f8c273fa5d36d7d3891aff643da8d9411adcb21ce26fd5cd2d3e3cd8f51::frusty {
    struct FRUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUSTY>(arg0, 6, b"Frusty", b"Frusty Sui", x"457665727920747261646572206e6565647320612074727573747920636f6d70616e696f6e2c0a736f6d656f6e6520746f207269646520746865207761766573206f6620746865206d61726b65742c0a63656c656272617465207468652077696e732c20616e64206c61756768207468726f756768207468650a6368616f732e2066727573747920697320746861742070656e6775696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia5gauzy2ylsyqepoc4ob3jamlwlogznqa6bym6itrsts3svvy3bu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRUSTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

