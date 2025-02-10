module 0x669bd7b48bc6a211293404e536cf129460b357760a360f4f344623565d5476d6::jailtuah {
    struct JAILTUAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILTUAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAILTUAH>(arg0, 9, b"JAILTUAH", b"Straight Tuah Jail", b"Straight Tuah Jail On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVd4HxMQ7Ah9CxxVL8iqKyqcqQ2Sn3k3z7mQR41FD2eUy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAILTUAH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAILTUAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILTUAH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

