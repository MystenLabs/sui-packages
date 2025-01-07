module 0x311a7f70a33d559a365a35e87c96c4023f8737263b5dc40b726b672902e8e5fe::beantoken {
    struct BEANTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEANTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEANTOKEN>(arg0, 6, b"BEANToken", b"BEAN", x"49276c6c2077697065206576657279206f6e65206f66207468656d21204576657279204c617374204f6e65204f662054686f7365204a45455445525320546861742773204f6e2053756920524556454e47452121212050726553616c65206f6e204d6f766550756d7009436f6d6d756e6974793a200a68747470733a2f2f742e6d652f6265616e746f6b656e736f6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4263_36a3d62cec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEANTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEANTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

