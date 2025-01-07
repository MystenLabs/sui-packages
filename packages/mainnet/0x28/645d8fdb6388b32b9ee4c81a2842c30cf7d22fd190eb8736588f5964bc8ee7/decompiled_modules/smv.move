module 0x28645d8fdb6388b32b9ee4c81a2842c30cf7d22fd190eb8736588f5964bc8ee7::smv {
    struct SMV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMV>(arg0, 9, b"SMV", b"SuiMove", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tse2.mm.bing.net/th?id=OIP.Mtz2hPN31y45yoCuvUiipAAAAA&pid=Api&P=0&h=180")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMV>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMV>>(v1);
    }

    // decompiled from Move bytecode v6
}

