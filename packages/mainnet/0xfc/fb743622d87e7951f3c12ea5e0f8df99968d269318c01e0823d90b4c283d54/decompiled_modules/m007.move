module 0xfcfb743622d87e7951f3c12ea5e0f8df99968d269318c01e0823d90b4c283d54::m007 {
    struct M007 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M007, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M007>(arg0, 6, b"007     ", b"AGENT 007 ", b"AGENT 007 is the official mascot o", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa.lol/Eu3woL           ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M007>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M007>>(v1);
    }

    // decompiled from Move bytecode v6
}

