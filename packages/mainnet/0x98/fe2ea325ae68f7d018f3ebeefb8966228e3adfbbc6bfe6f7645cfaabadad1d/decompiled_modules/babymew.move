module 0x98fe2ea325ae68f7d018f3ebeefb8966228e3adfbbc6bfe6f7645cfaabadad1d::babymew {
    struct BABYMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMEW>(arg0, 6, b"BABYMEW", b"Baby Mew On Sui", b"Become part of the Baby Mew family! Connect with fellow supporters, share ideas, and stay updated on the latest news and events. Lets grow together and spread the message of equality and fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E7_Y2_H9e8_400x400_5be8989ddf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

