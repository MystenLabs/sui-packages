module 0x8fa0f433c657075724513232d800033dcd069abdf46171ce03bd5c8d6372840f::ls {
    struct LS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LS>(arg0, 6, b"LS", b"LAZER SHARK", b"DECENTRALISED LAZER SHARK, NO TG, NO SOCIALS, NO WEBSITE JUST LAZERS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3947_9bbe00a49b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LS>>(v1);
    }

    // decompiled from Move bytecode v6
}

