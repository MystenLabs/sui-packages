module 0xd5552f26c309720a843bb08673504d18a0e8f6b66e557fd94a90b0278e643cc0::agu {
    struct AGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGU>(arg0, 6, b"Agu", b"000001", b"a gu  000001", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_3_dcaeee86d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

