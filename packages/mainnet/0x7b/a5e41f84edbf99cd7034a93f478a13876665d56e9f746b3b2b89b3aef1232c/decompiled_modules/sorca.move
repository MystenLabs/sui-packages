module 0x7ba5e41f84edbf99cd7034a93f478a13876665d56e9f746b3b2b89b3aef1232c::sorca {
    struct SORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORCA>(arg0, 6, b"SORCA", b"SORCA SUI", b"SORCA THE BLUE ORCA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sorca_3e99e238fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

