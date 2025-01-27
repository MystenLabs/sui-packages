module 0xd9677de054e4d901c4389d1a3c8441e0dc9fc6c01ea28d3d182303a951bc14a8::suijack {
    struct SUIJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJACK>(arg0, 6, b"SUIJACK", b"SUIJACKJACK", b"your favorite baby superhero is ready to take you to the moon supermemecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jack_Jack_44ada79362.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

