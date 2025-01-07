module 0x7aafca76cc8ed1634297eb4495f2ba4d88cd8c1c7df8277072f6f9c521d4df2b::kboom {
    struct KBOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBOOM>(arg0, 6, b"KBOOM", b"BOOM CAT", b"The first cat to EXPLODE on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_a2bfa2b073.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KBOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

