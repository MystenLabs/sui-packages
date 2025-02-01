module 0x71a215773b7df4a7629a3a40eae1394351a62a3f9fc8b4f90961a623724f7a66::tales {
    struct TALES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TALES>(arg0, 6, b"TALES", b"CRYPTKEEPER", x"41682c20746865726520796f75206172652120596f75277265206a75737420696e2074696d6521202e2e2e200a0a5b6c6175676873206d616e696163616c6c795d200a0a546f6e69676874277320666f756c2066656173742077696c6c20626567696e2077697468206d617368656420706f7461746f65732c207468656e206f6e746f20736f6d652073687269656b696e67206475636b20616e642066696e697368656420776974682061206e696365206b696c6c2d626173612e20492063616c6c2074686973207461737479207469646269742c204d6f75726e696e27204d6573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_50ab5b3af0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TALES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TALES>>(v1);
    }

    // decompiled from Move bytecode v6
}

