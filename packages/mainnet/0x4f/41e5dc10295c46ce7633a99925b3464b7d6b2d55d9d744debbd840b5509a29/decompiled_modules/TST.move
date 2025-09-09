module 0x4f41e5dc10295c46ce7633a99925b3464b7d6b2d55d9d744debbd840b5509a29::TST {
    struct TST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TST>, arg1: 0x2::coin::Coin<TST>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TST>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TST>>(0x2::coin::mint<TST>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TST>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TST>>(arg0);
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 9, b"TST", b"TestCoin", x"54657374436f696e2028245453542920697320616e206578706572696d656e74616c206d656d65636f696e206372656174656420666f722074657374696e6720616e642066756e206f6e2074686520626c6f636b636861696e2e20497420686173206e6f207265616c2076616c75652c206a757374206120746f6f6c20746f206c6561726e2c20746573742c20616e64206578706572696d656e7420f09f9a80f09f90b82e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68bf734bc459a1.60412131.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

