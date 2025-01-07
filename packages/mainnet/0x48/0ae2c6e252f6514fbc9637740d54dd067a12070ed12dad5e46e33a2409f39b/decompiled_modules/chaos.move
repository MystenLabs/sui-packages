module 0x480ae2c6e252f6514fbc9637740d54dd067a12070ed12dad5e46e33a2409f39b::chaos {
    struct CHAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAOS>(arg0, 9, b"CHAOS", b"CHAOS CHAOS", b"CHAOSSSSSS token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreigz3ej6ufx2ktwicpolik6ewqnqblavejrjlhhqbsgs2rpkrowuiq.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHAOS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAOS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

