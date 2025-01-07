module 0x390d003cd18d70c8801b6841e32570e213892a399b1f0c7562b61e8cd32ca818::cave {
    struct CAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAVE>(arg0, 6, b"CAVE", b"CAVEMAN", x"50617472696f7420436176656d616e20697320746865206d656d6520746f6b656e20736d617368696e67207468726f756768207468652053554920626c6f636b636861696e207769746820612073746f6e6520636c7562206f662066726565646f6d21204c656164696e672068697320747269626520746f2066696e616e6369616c20696e646570656e64656e6365210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cav_00649cfe06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

