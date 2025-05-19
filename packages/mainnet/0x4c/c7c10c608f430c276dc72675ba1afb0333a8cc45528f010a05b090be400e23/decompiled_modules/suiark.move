module 0x4cc7c10c608f430c276dc72675ba1afb0333a8cc45528f010a05b090be400e23::suiark {
    struct SUIARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIARK>(arg0, 6, b"SUIARK", b"SUIARK On Sui", b"The thing you are seeing is a SUIARK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiagwzob3u2z3lztmv4cahzlgy3g5ncgvlvqnyxadk3x5j7terz3ya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIARK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

