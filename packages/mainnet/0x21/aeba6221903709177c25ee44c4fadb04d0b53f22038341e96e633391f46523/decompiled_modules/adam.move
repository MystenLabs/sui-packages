module 0x21aeba6221903709177c25ee44c4fadb04d0b53f22038341e96e633391f46523::adam {
    struct ADAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAM>(arg0, 6, b"Adam", b"Adam=satoshi", b"$adam is more likely to be the real satoshi than len as people predict on polymarket!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/725_e8f78e2c8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

