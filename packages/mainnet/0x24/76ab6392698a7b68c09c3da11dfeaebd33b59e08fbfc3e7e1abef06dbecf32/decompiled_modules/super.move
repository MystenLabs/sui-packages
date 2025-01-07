module 0x2476ab6392698a7b68c09c3da11dfeaebd33b59e08fbfc3e7e1abef06dbecf32::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 6, b"SUPER", b"SUIPERCYCLE (real)", b"You want to be part of the suipercycle ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yp55uu_a_400x400_91194cf685.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

