module 0xe213d0fc3c404e5e56127abb3494434de3216fc4864d07360c3073dbad0ed8e8::crock {
    struct CROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCK>(arg0, 6, b"CROCK", b"WitcCrock", b"CROCK is here to conquer the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibayc6x2rhr6orsfnwolyuq7akxbfyjncljbcqkyjzfbbkmwhg5k4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CROCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

