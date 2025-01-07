module 0xa74693a53538bd7e0317fa269801fa14413a8f6c07820c7c40b050128b9b18fd::soc {
    struct SOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOC>(arg0, 6, b"SOC", b"scarlet octopus", b"Welcome to the world of scarlet octopus  a unique meme currency featuring an elephant! scarlet octopusembodies friendship and joy, offering opportunities for community engagement and participation in events. Join our growing community and support scarlet octopus on its exciting journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/564_0a541f84ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

