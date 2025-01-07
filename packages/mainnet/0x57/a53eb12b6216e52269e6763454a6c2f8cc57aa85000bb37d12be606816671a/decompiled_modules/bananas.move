module 0x57a53eb12b6216e52269e6763454a6c2f8cc57aa85000bb37d12be606816671a::bananas {
    struct BANANAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANAS>(arg0, 6, b"BANANAS", b"Banana Duct-Taped to a Wall", x"4a75737420466f722046756e21212120486f6c642049542e0a0a536f7468656279732061756374696f6e65642074686520617274776f726b206279204d617572697a696f2043617474656c616e206f6e205765646e65736461793b20506965636520736f6c6420746f204a757374696e2053756e2c20666f756e646572206f662063727970746f63757272656e637920706c6174666f726d2054726f6e2c2077686f20706c616e7320746f20656174206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc3tml_Ha4_A_Ax_F_Pt_9ba3db729c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

