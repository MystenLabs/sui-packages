module 0xcd77f411765707a83593b02380805659875515d25a1cfe07ccc83b506882819c::eee {
    struct EEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEE>(arg0, 9, b"EEE", b"EEE", b"ccSdsdsdsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EEE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

