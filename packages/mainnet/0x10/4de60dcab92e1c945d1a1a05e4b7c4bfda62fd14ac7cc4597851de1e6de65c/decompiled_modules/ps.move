module 0x104de60dcab92e1c945d1a1a05e4b7c4bfda62fd14ac7cc4597851de1e6de65c::ps {
    struct PS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PS>(arg0, 6, b"PS", b"Pokemon Sucks!", x"4e6f20776562736974652c206e6f20582c206e6f2054656c656772616d2c206e6f20726f61646d61702c206e6f20506f6bc3a96d6f6e2c206a75737420627579207468697320736869742c20686f6c6420616e64206a6f6b6520706f6b656d6f6e202849662074686973207368697420746f6b656e20686974732031206d696c6c696f6e2c2049276c6c2063726561746520616e2058206163636f756e742c206d6179626529", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihlqedyuncznhnggmtzxb7ouj4guo2k3lz562l37k3dkyjfrhqhau")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

