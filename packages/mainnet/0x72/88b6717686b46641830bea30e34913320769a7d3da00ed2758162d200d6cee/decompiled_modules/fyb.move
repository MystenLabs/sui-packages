module 0x7288b6717686b46641830bea30e34913320769a7d3da00ed2758162d200d6cee::fyb {
    struct FYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYB>(arg0, 3, b"FYB", b"Fuck You Bitch", b"Fuck You!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FYB>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FYB>>(v1);
    }

    // decompiled from Move bytecode v6
}

