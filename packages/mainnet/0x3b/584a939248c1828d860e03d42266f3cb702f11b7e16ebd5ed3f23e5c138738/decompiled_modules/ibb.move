module 0x3b584a939248c1828d860e03d42266f3cb702f11b7e16ebd5ed3f23e5c138738::ibb {
    struct IBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBB>(arg0, 6, b"IBB", b"I'm Back, Baby!", x"f09f9a802049424220e2809320427920446567656e732c20466f7220446567656e7320f09f9a8020200a5468652050656f706c65e280997320436f6d656261636b20436f696e20697320686572652e204e6f2067686f7374732c206e6f206c69657320e28093206a757374207075726520646567656e20666972652e204275726e65642062792066616b65207465616d733f20576520686f6c6420746865206c696e6521204a6f696e2075732c20726973652075702c20616e6420726964652049424220746f20746865206d6f6f6e2e20f09f8c95f09f94a520494242203a205468652050656f706c65277320436f696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731206993916.21")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

