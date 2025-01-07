module 0xbd5679402d39e90428fbaed6d7caa3fa0a5fd433e46ff1a6956c4da99f2e47f6::spg {
    struct SPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPG>(arg0, 6, b"SPG", b"Sui penguin", b"new sui memecoin lets come together and do this that how penguin does ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1564_da7ec00ee2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

