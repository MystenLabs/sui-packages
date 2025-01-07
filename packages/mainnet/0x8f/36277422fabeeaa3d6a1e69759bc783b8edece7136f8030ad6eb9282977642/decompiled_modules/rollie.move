module 0x8f36277422fabeeaa3d6a1e69759bc783b8edece7136f8030ad6eb9282977642::rollie {
    struct ROLLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLLIE>(arg0, 6, b"ROLLIE", b"ROLLIE SUI", b"I just want a Rollie, Rollie, Rollie with a dab of ranch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ROLLIE_2731a4d11c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLLIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLLIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

