module 0xd52f6acfeb91eebe1f5f1ba57ac27fae4f4aa144f80fc6235c3d51ada1eb777f::snt {
    struct SNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNT>(arg0, 6, b"SNT", b"Sui Nigga Trump", x"41796f2c20746869732061696e74206a757374206120746f6b656e2c2069747320612077686f6c65206d6f76656d656e742c207961206665656c206d653f2024534e54206272696e67696e20746861742062696720626f737320656e6572677920746f207468652067616d652c2064726970706564206f757420696e2041492073617563652c207370697474696e20626172732c206d616b696e20706f776572206d6f7665732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snt_d38b6c051a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

