module 0x7ea16954356ce6070ff7db231900de44846b8a3b957a88c3a4c11c43597dd768::mogy {
    struct MOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGY>(arg0, 6, b"MOGY", b"MOGY SUI", x"4d4f47592c2074686520746f6b656e20746861742074616b657320796f75206265796f6e64207468652073746172732120496e73706972656420627920616476656e7475726520616e64207370616365206578706c6f726174696f6e2c204d4f4759206973206d6f7265207468616e206a7573742061206d656d65636f696e2c20697320612067616c616374696320636f6d6d756e6974792077686572652063727970746f63757272656e637920656e74687573696173747320636f6d6520746f67657468657220746f2063656c656272617465206372656174697669747920616e642066756e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/002726ed_f9e7_4a85_9500_0846abbb688c_fec4bd980e_5c4ad4b02f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

