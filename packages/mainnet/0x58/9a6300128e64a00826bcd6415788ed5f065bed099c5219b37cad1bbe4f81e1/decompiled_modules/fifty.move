module 0x589a6300128e64a00826bcd6415788ed5f065bed099c5219b37cad1bbe4f81e1::fifty {
    struct FIFTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIFTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIFTY>(arg0, 9, b"FIFTY", b"STREAMING TILL 50 MILLION", x"53545245414d494e472054494c4c203530204d494c4c494f4e204d41524b455420434150204c495645204f4e204b49434b2068747470733a2f2f6b69636b2e636f6d2f73747265616d696e6774696c6c35306d696c6c696f6e0d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRLciTEvptMPgyWAcWwxmZ5WSR51FSUpm8n1NxhzfvhVp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIFTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIFTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIFTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

