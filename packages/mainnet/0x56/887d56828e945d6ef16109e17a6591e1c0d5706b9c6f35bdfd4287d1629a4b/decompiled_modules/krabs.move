module 0x56887d56828e945d6ef16109e17a6591e1c0d5706b9c6f35bdfd4287d1629a4b::krabs {
    struct KRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABS>(arg0, 6, b"KRABS", b"KRABSUI", b"The most original and badass Krabs, made for the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/krabs_500_500_5fd89024d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

