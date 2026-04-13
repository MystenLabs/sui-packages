module 0x4a8dba201bfea7eaed3daf83573a0239a7572a56b6602028ed0736201ab85d1c::b_sui {
    struct B_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUI>(arg0, 9, b"bSUI", b"bToken SUI", b"TURBOS bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.turbos.finance/icon/turbosbtoken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

