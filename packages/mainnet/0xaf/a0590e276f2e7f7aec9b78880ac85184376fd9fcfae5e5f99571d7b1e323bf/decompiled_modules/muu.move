module 0xafa0590e276f2e7f7aec9b78880ac85184376fd9fcfae5e5f99571d7b1e323bf::muu {
    struct MUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUU>(arg0, 6, b"MUU", b"Muu Cow", b"Can't stop won't stop (thinking about MUUNEY)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_cow_39d40387a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

