module 0x89a58cb1d4a9d2f5e76bfd893641963520bf94638b097647ef7726d2aa7df2f1::slama {
    struct SLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAMA>(arg0, 6, b"SLAMA", b"SPITLAMA", x"486f6c64696e6720534c414d41206772616e747320796f75207669727475616c207370697420706f7765722e20546865206d6f726520534c414d4120796f75206f776e2c20746865207374726f6e67657220796f7572207370697474696e67206162696c6974696573206265636f6d65202877697468696e20746865206469676974616c207265616c6d2c206f6620636f75727365292e0a0a54686520534c414d4120746f6b656e2069732061206d656d6520636f696e2064657369676e656420666f722068756d6f722c20636f6d6d756e69747920656e676167656d656e742c20616e64206120746f756368206f66206162737572646974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SLAMA_85e8695b86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

