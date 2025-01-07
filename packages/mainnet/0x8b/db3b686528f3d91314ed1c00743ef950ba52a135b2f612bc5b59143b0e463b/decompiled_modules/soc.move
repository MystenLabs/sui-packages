module 0x8bdb3b686528f3d91314ed1c00743ef950ba52a135b2f612bc5b59143b0e463b::soc {
    struct SOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOC>(arg0, 9, b"SOC", b"scarlet octopus", b"Welcome to the world of scarlet octopus a unique meme currency featuring an elephant! scarlet octopusembodies friendship and joy, offering opportunities for community engagement and participation in events. Join our growing community and support scarlet octopus on its exciting journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F564_0a541f84ce.jpg&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

