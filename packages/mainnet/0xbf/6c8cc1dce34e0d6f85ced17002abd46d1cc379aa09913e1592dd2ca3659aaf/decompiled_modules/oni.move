module 0xbf6c8cc1dce34e0d6f85ced17002abd46d1cc379aa09913e1592dd2ca3659aaf::oni {
    struct ONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONI>(arg0, 6, b"ONI", b"THE DEVIL ONI", x"544845204c4954544c4520444556494c204f4e49200a0a496e204a6170616e65736520666f6c6b6c6f72652c204f6e69206172652064656d6f6e73206f72206f677265732e205468657920617265207479706963616c6c79206c6172676520616e642073636172792d6c6f6f6b696e67207769746820726564206f7220626c756520736b696e2c20686f726e732c20616e6420736861727020636c6177732e205468657920617265206b6e6f776e20666f7220746865697220737472656e67746820616e64206c6f766520746f2063617573652074726f75626c652e20536f6d6574696d65732c207468657920617265206576656e207361696420746f206561742070656f706c6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deviloni_2e413f2dec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

