module 0xeada0748ad6f6e735999630540c2518213f56d6e161e2b7feda93892e1d05fd0::deer {
    struct DEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEER>(arg0, 6, b"Deer", b"DEER", b"sliding into someones DMs late at night", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9032_3229ba70be.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

