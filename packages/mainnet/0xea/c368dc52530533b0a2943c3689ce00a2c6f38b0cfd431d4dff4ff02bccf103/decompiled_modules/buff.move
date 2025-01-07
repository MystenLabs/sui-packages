module 0xeac368dc52530533b0a2943c3689ce00a2c6f38b0cfd431d4dff4ff02bccf103::buff {
    struct BUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFF>(arg0, 6, b"BUFF", b"Suicken", x"41626f75742024425546462c0a7468652053756920636869636b656e2e0a576974682068697320696d7072657373697665206d7573636c657320616e6420756e73746f707061626c65207370697269742c207768657265206c6576656c696e6720757020616e6420627265616b696e67206c696d69747320697320746865206b657920746f2073756363657373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Photo_26_9_24_7_41_04_PM_98980f2ab8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

