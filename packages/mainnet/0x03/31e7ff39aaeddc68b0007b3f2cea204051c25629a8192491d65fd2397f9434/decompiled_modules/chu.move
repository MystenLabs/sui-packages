module 0x331e7ff39aaeddc68b0007b3f2cea204051c25629a8192491d65fd2397f9434::chu {
    struct CHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHU>(arg0, 9, b"CHU", b"Suichu", x"41206375746520506f6bc3a96d6f6e20726573656d626c696e672050696b616368752c2077697468206c6967687420626c75652066757220616e642077617679207061747465726e732074686174206c6f6f6b206c696b652077617465722064726f706c657473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"file:///C:/Users/User/Downloads/image.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHU>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

