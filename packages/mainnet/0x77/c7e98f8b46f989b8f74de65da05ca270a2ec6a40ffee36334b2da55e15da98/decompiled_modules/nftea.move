module 0x77c7e98f8b46f989b8f74de65da05ca270a2ec6a40ffee36334b2da55e15da98::nftea {
    struct NFTEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFTEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFTEA>(arg0, 9, b"NFTEA", b"Cutie ", x"43757469653a2074686520637574657374206d656d6520636f696e20737072656164696e6720736d696c657320616e642066756e206163726f7373207468652063727970746f20776f726c6421204a6f696e207468652043757469652066616d696c7920616e64206164642061206c6974746c65206a6f7920746f20796f75722063727970746f206a6f75726e65792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c0a193c-7a95-4db8-9956-27f7eec8a227.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFTEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFTEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

