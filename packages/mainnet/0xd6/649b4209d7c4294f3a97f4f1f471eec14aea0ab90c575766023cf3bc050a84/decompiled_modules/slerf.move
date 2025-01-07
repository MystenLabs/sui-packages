module 0xd6649b4209d7c4294f3a97f4f1f471eec14aea0ab90c575766023cf3bc050a84::slerf {
    struct SLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLERF>(arg0, 6, b"Slerf", b"SlerfTueSloth", b"You can farm the first token thats going to be launched on their platform right now in real time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWLqnDS7hEnXAKfZJSEeYCvAN9MXAsHGrsHWxRLZqeaXZ?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLERF>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERF>>(v2, @0x236aa176e48b5d14bcc28a674c1eb01ccde386f70f737346949577e0228e3f6f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

