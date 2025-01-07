module 0xaae860f16431f030440ebae5b8defb9a565e7512294ba1e8e14289dc5392a278::babymiharu {
    struct BABYMIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMIHARU>(arg0, 9, b"BABYMIHARU", b"Baby Miharu Wif Hat", b"Baby Miharu Wif Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmR3kjnxCpy3M7WJHY5eSZA7jdh65NhhP5VShC4j8pTWEC"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYMIHARU>>(v1);
        0x2::coin::mint_and_transfer<BABYMIHARU>(&mut v2, 1000000000000000000, @0xf7bd67354b18a09879d3b224686095ed14b6bfc9b888c419d8af7c4dfce2dc6a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BABYMIHARU>>(v2);
    }

    // decompiled from Move bytecode v6
}

