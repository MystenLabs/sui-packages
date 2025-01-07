module 0x5f384d006095aeec498c72601519ec2a862af574dfcec732549afe29d08098ce::cama {
    struct CAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAMA>(arg0, 6, b"CAMA", b"CAT MAGIC", b"https://x.com/justinsuntron/status/1842109860630167866", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZB_9_J0_b_AAE_Xh_Xb_a9fdabf0a6.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

