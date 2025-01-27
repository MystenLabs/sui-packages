module 0xd4295c2315788c657777075db0d809fb0331ad17e357ac7b16f6cb0b82c5d8d::suijack {
    struct SUIJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJACK>(arg0, 6, b"Suijack", b"Suijackjack", b"your child superhero is ready to take you to the moon supermemecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jack_Jack_e29cdde119.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

