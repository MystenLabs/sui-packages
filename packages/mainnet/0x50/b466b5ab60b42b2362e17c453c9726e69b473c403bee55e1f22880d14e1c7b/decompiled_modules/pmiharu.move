module 0x50b466b5ab60b42b2362e17c453c9726e69b473c403bee55e1f22880d14e1c7b::pmiharu {
    struct PMIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMIHARU>(arg0, 6, b"Pmiharu", b"Pop Miharu", b"100m marketcap coming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fsfsfsdf_ccab5550e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMIHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

