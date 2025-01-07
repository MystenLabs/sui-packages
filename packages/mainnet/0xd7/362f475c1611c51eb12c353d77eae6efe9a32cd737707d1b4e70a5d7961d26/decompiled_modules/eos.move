module 0xd7362f475c1611c51eb12c353d77eae6efe9a32cd737707d1b4e70a5d7961d26::eos {
    struct EOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EOS>(arg0, 6, b"EOS", b"E of SUI", b"give me EEEEEEEEEEEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_c_2_189aaccf6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

