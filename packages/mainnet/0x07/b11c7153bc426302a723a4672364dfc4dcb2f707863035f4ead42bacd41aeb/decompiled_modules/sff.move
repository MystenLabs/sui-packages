module 0x7b11c7153bc426302a723a4672364dfc4dcb2f707863035f4ead42bacd41aeb::sff {
    struct SFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFF>(arg0, 6, b"SFF", b"Smoking Fliying Fish", x"446f20796f75207468696e6b206265636f6d696e6720746865206b696e67206f66207468652073656120616e6420666c79696e6720746f20746865206d6f6f6e20736f756e647320686172643f0a0a486520736d6f6b657320756e64657277617465723b0a6265636f6d696e6720746865206b696e67206f6620746865206f6365616e20616e64207265616368696e6720746865206d6f6f6e2069732061207069656365206f662063616b652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Estate_preparado_1_removebg_preview_1_0faeb54292.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

