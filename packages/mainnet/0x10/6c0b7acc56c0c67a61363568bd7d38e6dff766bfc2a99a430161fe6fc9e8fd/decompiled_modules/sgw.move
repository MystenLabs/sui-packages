module 0x106c0b7acc56c0c67a61363568bd7d38e6dff766bfc2a99a430161fe6fc9e8fd::sgw {
    struct SGW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGW>(arg0, 6, b"SGW", b"SuiGuard Wallet", b"Sui Guard Wallet is designed to enhance user experience on the Sui blockchain by providing a secure and efficient way to manage digital assets. It offers features such as easy access to decentralized applications (dApps), seamless transactions, and robust security measures. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_19_12_07_58_d9e2a70e98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGW>>(v1);
    }

    // decompiled from Move bytecode v6
}

