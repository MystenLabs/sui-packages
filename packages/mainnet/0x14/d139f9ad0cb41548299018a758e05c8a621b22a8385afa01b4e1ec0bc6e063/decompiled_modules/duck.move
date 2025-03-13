module 0x14d139f9ad0cb41548299018a758e05c8a621b22a8385afa01b4e1ec0bc6e063::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"DUCKmyDUCK", x"4469766520696e746f20746865206669727374204d656d654e46542067616d65207768657265206475636b7320646f2074686520646972747920776f726b2e200a0a466565640a42726565640a5472616465204475636b7320616e64204561726e2024444d44200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000161_023ee9c198.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

