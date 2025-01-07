module 0x54ea62e65cd179fef729cec05ada85343f53bb10127ec214cb80ed635b8948b9::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"Sui Slime", x"4d6565742053756920536c696d652e20576f62626c792c20636f6c6f7266756c2c20616e642066756c6c206f6620737572707269736573212024534c494d45206f6f7a6573207468726f7567682074686520537569204e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_1_5cc8464e0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

