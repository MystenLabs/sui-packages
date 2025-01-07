module 0xcc4811b61c73f5de186a5562c0803f3ee9eb6f1ed053f37c0e20a181bcb04a75::mel {
    struct MEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEL>(arg0, 6, b"MEL", b"Melanoqtx", x"486921204d79206e616d65206973204d656c616e6f20616e64204920616d20612043532073747564656e742c206c6561726e696e67206d616368696e65206c6561726e696e67206173206120686f6262792e20496e7465726573747320696e636c7564652c2062757420617265206e6f74206c696d6974656420746f20626f6f6b732c2063696e656d612c2070686f746f6772617068792c206d7573696320616e64206f682c206d616368696e65732028676f7420612068617264636f7265207468696e6720666f72207468656d2c206e6f206a6f6b65292e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pc4u_K1_Yb_K_He9j_Vi_Dut_RE_6ov6n_Ntiq9_Lw5ph_G4r_D6_CZ_Gz_6c695a49c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

