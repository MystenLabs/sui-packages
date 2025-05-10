module 0x1a89a39f8bbc4471a2197a51a27d1fdbb2da95d2684b8a519095ad6f7bcd07aa::hippo_token {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun internal_init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HIPPO{dummy_field: true};
        let (v1, v2) = 0x2::coin::create_currency<HIPPO>(v0, 9, b"HIPPO", b"hippo", b"SuDeng is the cutest $HIPPO on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/j2EuFh5.png")), arg0);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO>>(v2);
        0x2::coin::mint_and_transfer<HIPPO>(&mut v3, 10000000000000000000, 0x2::tx_context::sender(arg0), arg0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v3, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HIPPO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HIPPO>(arg0, arg1, arg2, arg3);
    }

    public entry fun start(arg0: &mut 0x2::tx_context::TxContext) {
        internal_init(arg0);
    }

    // decompiled from Move bytecode v6
}

