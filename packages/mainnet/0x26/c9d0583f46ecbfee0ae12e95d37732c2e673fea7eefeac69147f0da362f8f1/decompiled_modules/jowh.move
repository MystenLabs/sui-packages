module 0x26c9d0583f46ecbfee0ae12e95d37732c2e673fea7eefeac69147f0da362f8f1::jowh {
    struct JOWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOWH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JOWH>(arg0, 6, b"JOWH", b"JollyWhale", x"4a6f6c6c795768616c65206973206d6f7265207468616e2061206d656d6520746f6b656ee2809469742773206120636174616c79737420666f72206368616e67652e20427920646f6e6174696e67206120706f7274696f6e206f662065616368207472616e73616374696f6e20746f206120646966666572656e7420636861726974792065616368206d6f6e7468207468726f756768206120636f6d6d756e69747920766f7465e28094206d616b696e67206576657279207472616465206e6f74206f6e6c792070726f66697461626c652062757420696d7061637466756c2e204a6f696e20757320616e64206d616b6520612073706c61736820666f7220672e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000116746_35818112b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOWH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOWH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

