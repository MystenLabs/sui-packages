module 0xd5b2f6c2d941a5316f9395614b9cb4ce4eeef804c30a36bba558d435b1c43a2b::moe {
    struct MOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOE>(arg0, 9, b"Moe", b"TESTT", b"no", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/139507bf800e1cdb47b6bc3f64ddf85ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

