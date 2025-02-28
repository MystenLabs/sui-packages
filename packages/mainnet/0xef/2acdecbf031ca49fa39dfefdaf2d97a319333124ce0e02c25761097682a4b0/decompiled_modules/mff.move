module 0xef2acdecbf031ca49fa39dfefdaf2d97a319333124ce0e02c25761097682a4b0::mff {
    struct MFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFF>(arg0, 9, b"MFF", b"Mav Fab", b"Just a MAV Fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c201b1ad0ec35492865754e1cc227787blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

