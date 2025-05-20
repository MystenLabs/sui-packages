module 0x96a89f9129582998726369fe4aabe3bbb2f5a6d48a599b6b0dd0cb0a1c0d3424::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 9, b"SIU", b"SIU", b"This is SIU token based on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/21896a23-4015-4ffa-bc7c-cdf35d0fb857.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIU>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

