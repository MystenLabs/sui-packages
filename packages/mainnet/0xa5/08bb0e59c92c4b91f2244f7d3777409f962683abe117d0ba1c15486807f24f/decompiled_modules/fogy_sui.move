module 0xa508bb0e59c92c4b91f2244f7d3777409f962683abe117d0ba1c15486807f24f::fogy_sui {
    struct FOGY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOGY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOGY_SUI>(arg0, 6, b"FOGY", b"FOGY", b"did you know about FOGY?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://turquoise-worried-tapir-661.mypinata.cloud/ipfs/QmRcdXTBdYYR2VG1SZF1ASxVXfWKoRFPTW1YxM8zV1qahf")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOGY_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FOGY_SUI>>(0x2::coin::mint<FOGY_SUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FOGY_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

