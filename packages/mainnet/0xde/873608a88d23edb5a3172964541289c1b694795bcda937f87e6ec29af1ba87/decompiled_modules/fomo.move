module 0xde873608a88d23edb5a3172964541289c1b694795bcda937f87e6ec29af1ba87::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 6, b"FOMO", b"Father Of Meme", x"52696368617264204461776b696e732069732074686520466174686572206f6620746865204d656d652e20546865204f726967696e206f6620616c6c206d656d65732e20546865206d616e2077686f207075742050657065206f6e2042696e616e63652c20746865206d616e2077686f207075742057616c6c53742042756c6c20776966204861742e20526963686172642068617320636f6d65206261636b20746f207265636c61696d20746865206d656d652e20546f2073686f772074686520756e6976657273652c207768617420697320746568207265616c206d656d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_09_10_30_43_b3c1f218c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

