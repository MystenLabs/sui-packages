module 0x3db8f9ccd14691f4b749f285911891315424bdecb62c446f9ccb74421e338a44::m2r {
    struct M2R has drop {
        dummy_field: bool,
    }

    fun init(arg0: M2R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M2R>(arg0, 9, b"M2R", b"M2 Realty ", x"546f20656d706f7765722065766572796461792070656f706c6520e28094207374617274696e6720696e20526f6262696e732c20496c6c696e6f697320616e6420657870616e64696e67206f75747761726420e2809420746f20636f2d6f776e2c2066756e642c20616e64206275696c64207265616c207765616c7468207468726f756768207265616c206573746174652070726f6a65637473207573696e6720626c6f636b636861696e20746563686e6f6c6f67792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmeFcnErrEqtLa79YAZ2LxxBeij65TLsEEN4v7hqwRN3jb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<M2R>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M2R>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<M2R>>(v1);
    }

    // decompiled from Move bytecode v6
}

