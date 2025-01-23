module 0xa5b3dd8fa5bffeb600709234fab361ed0cad9650e2e17cbceb4bdd02aaaf9ffe::cct {
    struct CCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCT>(arg0, 6, b"CCT", b"CyberCorp Terminal", x"57656c636f6d6520746f2074686520756e64657262656c6c79206f6620746865206469676974616c20776f726c642e20596f7520617265206e6f206c6f6e676572206a7573742061206861636b6572202d20796f7520617265206120676c6974636820696e207468652073797374656d2c20616e20616e6f6d616c792e0a0a43616e20796f7520627265616b20667265652066726f6d20746865206d617472697820616e64206265636f6d652074686520756c74696d61746520676c69746368207769746820244343543f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sedsdsdsdsds1111_93d27a945d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

