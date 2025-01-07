module 0x8adfd1f7a1d14a6770dcb6433c844a8c7635797af96bf70c4f2d1daef0019df3::babybull {
    struct BABYBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBULL>(arg0, 6, b"BabyBull", b"BabyBull Token", x"4f6666696369616c20244261627962756c6c206f6e2040582e20636f6d6d756e697479206d616e616765640a576564736974653a20687474703a2f2f6261627962756c6c7375692e6c6f6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Avatar_f405dba25f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

