module 0x16ac152b73294cee374a98ce4c4414fd65d6f3a78e95183da851761a3cb496fa::fffsgdfdsg {
    struct FFFSGDFDSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFSGDFDSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFSGDFDSG>(arg0, 6, b"FFfsgdfdsg", b"dsafas", b"dsafdasdfasfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111111111111_8bab6290f0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFSGDFDSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFFSGDFDSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

