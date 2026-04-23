module 0xd0fcfd422a7741aa579c1630a93c0ca65749a16c56dfaefdfabcb0148ba946c3::m007 {
    struct M007 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M007, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M007>(arg0, 6, b"007     ", b"AGENT 007 ", b"AGENT 007 is the official mascot o", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa.lol/B68TQg           ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M007>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M007>>(v1);
    }

    // decompiled from Move bytecode v6
}

