module 0xddc3e981dfff9110e670dfdf6729b6478cd6a9d64527aa00d218146d13a6d3ac::mdog {
    struct MDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDOG>(arg0, 6, b"MDOG", b"MOVEDOG", b"MOVE Dog, the biggest dog meme on SUI, every chain needs its dog, every dog has its day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016479_a13209618a_f4d2ed7d8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

