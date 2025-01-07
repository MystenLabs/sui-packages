module 0xda7ecebe6ec0c4cecc507542f8f26f155b4012aa1dc83a59c98b19fc54a56b82::spw {
    struct SPW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPW>(arg0, 6, b"SPW", b"Sparrow Token", x"f09f8fb4e2808de298a0efb88f2053706172726f7720546f6b656e20e28093205468652043727970746f204c6f6f74205965204e6565642120f09fa69cf09f92b80a0a41686f79212053706172726f77e28099732061626f757420746f2064726f702074726561737572652c204e4654732c20616e642072657761726473206c696b652063616e6e6f6e62616c6c732120446f6ee280997420626520746865206c616e646c7562626572206c65667420626568696e6420e28093206a6f696e20746865206372657720616e642073636f7265206269672120f09faa99f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731326873119.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

