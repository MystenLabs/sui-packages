module 0x7f23ea52c62d40c240b35b83bbce1d95ac3431638fc8d6bdcc31b6c5c49e94a4::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKO>(arg0, 6, b"SUIKO", b"SuiKo", x"4e6f206a656574732e204e6f204655442e204a757374207075726520646567656e206d6f7665732e205741474d492c20627574206f6e6c7920696620796f75e280997265206661737420656e6f75676820746f2061706520696e207768656e207468652074696d6520636f6d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960787012.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

