module 0x37b32ae6ed873ba7e87711419d179c764902573cb317cec5025e847b9dc303d1::stewie {
    struct STEWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEWIE>(arg0, 9, b"STEWIE", b"Stewie", b"Stewie Griffin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1846444498458402817/0wJLLt0z_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STEWIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEWIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEWIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

