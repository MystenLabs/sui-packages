module 0x157f5f24d714663871a88f1c7a8f5a287c377e117becab3372f6681066bff8d1::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"Cat On Sui", x"436174206973206120436f6d6d756e6974792064726976656e2066756e20616e64206578636974696e670a6d656d65636f696e206f6e205375692120776520706c616e20746f206272696e67207468652074696d6573206f66206269670a6d6f6f6e73686f7473206261636b20746f2053756921204361742077656c636f6d657320616c6c207768616c657320616e6420696e766573746f727320746f206a6f696e20757320616e64206d616b652053756920477265617420616761696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_14_17_18_30_360872e006.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

