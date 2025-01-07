module 0xc22ac0aa67c11070780b282c3098b89a71620c371714e371d05fd6442898533d::cat20 {
    struct CAT20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT20>(arg0, 9, b"CAT20", b"CAT-20", b"OP_CAT on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9abae645-edc5-4373-8e26-070a29d915f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT20>>(v1);
    }

    // decompiled from Move bytecode v6
}

