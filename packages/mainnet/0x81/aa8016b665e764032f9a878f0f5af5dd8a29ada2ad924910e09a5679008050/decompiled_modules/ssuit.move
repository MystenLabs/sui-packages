module 0x81aa8016b665e764032f9a878f0f5af5dd8a29ada2ad924910e09a5679008050::ssuit {
    struct SSUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUIT>(arg0, 6, b"SSUIT", b"Suisuit", x"5468652073757065726865726f2020616e64206869730a616476656e74757265206f6e20746865205355490a626c6f636b636861696e0a0a4f6e636520612063656c656272617465640a636f6d70616e696f6e206f662068756d616974792c20746869730a535549535549542073746f727920756e726176656c732066726f6d0a746563686e6f6c6f676963616c2072656c6576616e636520746f0a736f63696574616c206f626c6976696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/13bffe74_f12a_439e_a1c4_dcd3c2623d32_38a4ea744c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

