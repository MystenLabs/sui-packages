module 0x53139c0cb206644ce77f1392dc838c34a78351553fe9f9accd45613363c95938::mango_republic_xyz183 {
    struct MANGOZILLA9981 has drop {
        dummy_field: bool,
    }

    fun internal_init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MANGOZILLA9981{dummy_field: true};
        let (v1, v2) = 0x2::coin::create_currency<MANGOZILLA9981>(v0, 9, b"MZILLA", b"MANGOZILLA9981", b"The rarest mango beast ever created. Not for consumption.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/2kE91zP.png")), arg0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANGOZILLA9981>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANGOZILLA9981>>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANGOZILLA9981>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANGOZILLA9981>(arg0, arg1, arg2, arg3);
    }

    public entry fun start(arg0: &mut 0x2::tx_context::TxContext) {
        internal_init(arg0);
    }

    // decompiled from Move bytecode v6
}

