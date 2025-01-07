module 0x5ff601c273107a716e5e4942f1b4cffe69165c2a5d0f0702837dfa9ba28124b6::otto {
    struct OTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTO>(arg0, 6, b"OTTO", b"OTTO ON SUI", b"The agile otter of the Sui blockchain, optimized for speed and fluidity in digital transactions. Built for scalability and efficiency, $OTTO glides through the Sui waters, offering holders rapid transaction speeds and streamlined operations. Dive into the Sui ecosystem with $OTTO and experience liquidity, velocity, and seamless performance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OTTIER_1ab9ac634b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

