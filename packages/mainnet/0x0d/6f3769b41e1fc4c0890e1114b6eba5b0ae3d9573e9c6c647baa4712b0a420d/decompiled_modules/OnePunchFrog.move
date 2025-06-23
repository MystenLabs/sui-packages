module 0xd6f3769b41e1fc4c0890e1114b6eba5b0ae3d9573e9c6c647baa4712b0a420d::OnePunchFrog {
    struct ONEPUNCHFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEPUNCHFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEPUNCHFROG>(arg0, 9, b"OPF", b"OnePunchFrog", b"just a frog for fun. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/d06bb4fe-74d7-4287-9cbd-c1273eb00625.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEPUNCHFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEPUNCHFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

