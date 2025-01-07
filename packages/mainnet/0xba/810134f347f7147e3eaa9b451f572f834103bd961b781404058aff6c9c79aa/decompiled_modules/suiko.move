module 0xba810134f347f7147e3eaa9b451f572f834103bd961b781404058aff6c9c79aa::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKO>(arg0, 6, b"SUIKO", b"SUIKO ", x"4e6f206a656574732e204e6f204655442e204a757374207075726520646567656e206d6f7665732e205741474d492c20627574206f6e6c7920696620796f75e280997265206661737420656e6f75676820746f2061706520696e207768656e207468652074696d6520636f6d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963340087.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

