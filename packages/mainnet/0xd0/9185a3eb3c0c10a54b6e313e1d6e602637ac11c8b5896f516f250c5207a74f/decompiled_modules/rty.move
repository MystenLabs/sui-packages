module 0xd09185a3eb3c0c10a54b6e313e1d6e602637ac11c8b5896f516f250c5207a74f::rty {
    struct RTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTY>(arg0, 6, b"RTY", b"TightToken", b"TightToken for learn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ih1.redbubble.net/image.5148959844.2540/st,small,507x507-pad,600x600,f8f8f8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RTY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

