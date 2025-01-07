module 0x4a552082102c834712631680f0980c5546e7df8af413ad8ddb7e99fb087798a2::cwm {
    struct CWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWM>(arg0, 7, b"CWM", b"Cyber Wolf Man", b"Cyber Wolf Man is a meme coin to honor the memory of the wolf man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J7WZ5mu.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CWM>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWM>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWM>>(v1);
    }

    // decompiled from Move bytecode v6
}

