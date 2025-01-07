module 0x98c6d94fd309f455f225b388c229af19d5a594497c07ae41933ab53a24f749d::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"Ray on Sui", x"5468652024526179207468617420736d6f6b657320756e646572207468652077617465722e0a0a546865207465616d2077696c6c206d616b6520616e20696e697469616c20707572636861736520746861742077696c6c206265207573656420746f3a0a0a3330252061697264726f7020666f72205375692773204f47732e0a353025204d61726b6574696e67202864657873637265656e657220706169642c20776562736974652c2063616c6c73290a323025207465616d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/reay_2_bc3027dfe2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

