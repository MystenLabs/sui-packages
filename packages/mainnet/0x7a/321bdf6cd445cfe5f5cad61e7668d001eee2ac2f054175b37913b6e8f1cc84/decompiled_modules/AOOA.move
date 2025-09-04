module 0x7a321bdf6cd445cfe5f5cad61e7668d001eee2ac2f054175b37913b6e8f1cc84::AOOA {
    struct AOOA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AOOA>, arg1: 0x2::coin::Coin<AOOA>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<AOOA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AOOA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AOOA>>(0x2::coin::mint<AOOA>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<AOOA>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AOOA>>(arg0);
    }

    fun init(arg0: AOOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOOA>(arg0, 9, b"aOOa", b"Ancient Order of Absurdity", x"41204d656d652041727469737420416363656c657261746f722e20576520646f6ee2809974206a75737420746f6c6572617465206d656d65206172746973747320e280942077652068656c70207468656d206561726e20666f72206372656174696e672e20466f756e646564206279206372656174697665732c20666f72206372656174697665732e204c6561726e20746f206d616b6520636f6e74656e742077697468206e6578742d67656e20414920746f6f6c732e204372656174652e204578706572696d656e742e2050726f6d6f74652e20416e6420627920686f6c64696e672c20796f752067657420706169642e2054686520416e6369656e74204f72646572206f662041627375726469747920697320616e206578706572696d656e743a20686f77206661722063616e206120636f6d6d756e69747920676f207768656e206372656174697669747920697320746865206f6e6c792063757272656e63793f20596f75206561726e20627920686f6c64696e6720614f4f612e20596f75206561726e206279206d616b696e67206e6f69736520746861742063616ee28099742062652069676e6f7265642e204d616b6520636f6e74656e7420e28692205261696420e286922047726f7720617474656e74696f6e20e28692204174747261637420686f6c6465727320e28692204275696c64206c6f7564657220e28692205265706561742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68b928434d7820.84569326.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AOOA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOOA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

