module 0x272684efac7e97f6206c84271d2930464bfbd2b9bf7da9ab2687f24d48bf2741::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"Suinic", x"4d656574205375696e69632c20746865206661737465737420746f6b656e206f6e2074686520537569206e6574776f726b2120496e73706972656420627920746865206c6567656e6461727920536f6e69632c205375696e696320697320737769667420616e642066756c6c206f6620656e657267792c207370656564696e67207468726f75676820626c6f636b7320616e64207472616e73616374696f6e732e204a6f696e20746869732063727970746f20616476656e747572652c207768657265207370656564206973206b657920616e64206d6f6f6e73686f747320617265206a7573742074686520626567696e6e696e67210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suinic_logo_5c5834e284.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

