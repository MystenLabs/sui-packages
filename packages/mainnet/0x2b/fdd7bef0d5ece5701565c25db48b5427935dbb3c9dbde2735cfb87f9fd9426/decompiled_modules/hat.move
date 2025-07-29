module 0x2bfdd7bef0d5ece5701565c25db48b5427935dbb3c9dbde2735cfb87f9fd9426::hat {
    struct HAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAT>(arg0, 6, b"HAT", b"Horse Aff Traffy", x"484154200a0a484154206973207468652076616c7565206f6620746865206675747572652c207768656e20796f752077616e7420746f2067726f77206368616f7320696e2061206365727461696e2077617920776974686f7574207265647563696e6720746865206465636c696e65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiew6ry4ztgq77rxfkxi3bu2cbi7hof33d4ooun7mzqzrpgf6dlxwe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

