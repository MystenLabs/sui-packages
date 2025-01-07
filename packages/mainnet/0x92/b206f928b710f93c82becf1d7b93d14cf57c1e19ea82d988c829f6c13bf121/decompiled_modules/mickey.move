module 0x92b206f928b710f93c82becf1d7b93d14cf57c1e19ea82d988c829f6c13bf121::mickey {
    struct MICKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICKEY>(arg0, 9, b"MICKEY", b"MICKEY", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/sco/d/d4/Mickey_Mouse.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MICKEY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

