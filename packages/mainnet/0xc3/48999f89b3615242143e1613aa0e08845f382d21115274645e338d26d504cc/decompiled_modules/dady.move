module 0xc348999f89b3615242143e1613aa0e08845f382d21115274645e338d26d504cc::dady {
    struct DADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADY>(arg0, 9, b"DADY", b"Father Sui", b"\"Father Sui\" is a token on the Sui blockchain symbolizing guidance, protection, and stability. It embodies leadership within the ecosystem, offering utility in governance and staking while fostering trust and community growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1774213023261229056/8IG7HdnN.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DADY>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

