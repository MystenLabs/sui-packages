module 0x395f56cde25223d1927a59baa8391e58152fe6e6f4c8723c74fe844c04a780e1::frug {
    struct FRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUG>(arg0, 6, b"Frug", b"Frug On Sui", x"412066726f67207468617473207365656e20697420616c6c20616e64206a757374206b6565707320676f696e672e612066726f67207468617473207365656e20697420616c6c20616e64206a757374206b6565707320676f696e672e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10_9f5a04db98_bf1349c211.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

