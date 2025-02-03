module 0xc8f6180969bb6079af7ba561f85bc5c8bbda081d72a8c6291031dcadf5b3493c::meco {
    struct MECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MECO>(arg0, 9, b"MECO", b"Meta ECO-friendly ", x"5765e280997265206275696c64696e67204d65746120526574726561742c2061206f6e652d6f662d612d6b696e6420686176656e2064657369676e656420666f722065766572796f6e65e2809466726f6d205a6f6f6d2d7468656d6520616e696d616c206c6f766572732028446f67652c20506570652c2053686962612c20636174732c20666973682c207069677320f09f90b7f09f90b6f09f90b1206d6f7265207468616e203135302062696c6c696f6e73206d61726b657420636170202920636f696e20686f6c6465727320616e642067656e6572616c20616476656e74757265727321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/c98ffd30-e22c-11ef-9eb9-99543e8f5bed")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MECO>>(v1);
        0x2::coin::mint_and_transfer<MECO>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MECO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

