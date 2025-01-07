module 0x59131042f9f89adef945b2f3110ef7c55521612fb04d94e1145ec281339b936e::bobby {
    struct BOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBBY>(arg0, 6, b"BOBBY", b"Bobby The Beaver", b"Bobby is a construction worker, and his new project is to build a huge coin on SUI, help him achieving his goal, and don't forget to bring materials!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_bb1fe1e5e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

