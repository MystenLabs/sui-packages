module 0x8484e1276a9ecd990e26cbc0328870868e7319aecb553a550dfa8477670858ba::uniinu {
    struct UNIINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIINU>(arg0, 6, b"UNIINU", b"UNICORNNRNOCINU", b"UNICORNNRNOCINU UNICORNNRNOCINU UNICORNNRNOCINU UNICORNNRNOCINU UNICORNNRNOCINU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adf_e669a4ea3d.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

