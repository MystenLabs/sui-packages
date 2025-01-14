module 0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 9, b"$MAN", b"MAN", b"MAN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiambo2yqxon36hv4q2ixyrkwr467d77b6kuef4z3ok6vyfjsdyhx4")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAN>>(v1);
        0x2::coin::mint_and_transfer<MAN>(&mut v2, 10000000000 * 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAN>>(v2);
    }

    // decompiled from Move bytecode v6
}

