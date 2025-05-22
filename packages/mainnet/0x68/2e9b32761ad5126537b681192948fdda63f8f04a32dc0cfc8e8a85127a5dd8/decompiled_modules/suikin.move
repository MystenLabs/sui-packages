module 0x682e9b32761ad5126537b681192948fdda63f8f04a32dc0cfc8e8a85127a5dd8::suikin {
    struct SUIKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIN>(arg0, 6, b"SUIKIN", b"Suikins", x"546865205375696b696e732e0a47726f772c2070657420616e64206c6f7665207468656d20616e6420746865792077696c6c206772696e642c20666967687420616e64206d616b6520796f75207374726f6e6b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiccj4ib7zlkvpvwt2btsduy5v7r5dqhduoi6cpu7njszl5wvdmprm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

