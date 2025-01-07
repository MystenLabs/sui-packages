module 0x520dec25cde47eac323c0c0295800ffa52007206c485c522a062da3f6ab5d4ab::percy {
    struct PERCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERCY>(arg0, 9, b"PERCY", b"Percy Verence", b"Elon started a new character called \"Percy Verence\", the Kekius Maximus Killer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmcf4rRJtFQGWU11aNKiCFsehgLd3D51a8Nh1PjDLZdaMM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PERCY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PERCY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERCY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

