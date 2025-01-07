module 0x6797c2465b19833c916c4b91dcf9a1dc513ef8584718167734fa5f57051a35da::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"AQUA YAMA", b"This is a real yama drinking some Aqua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6f9c6a17_4ce1_4782_8a01_5a12e08ba3fc_4003866a53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

