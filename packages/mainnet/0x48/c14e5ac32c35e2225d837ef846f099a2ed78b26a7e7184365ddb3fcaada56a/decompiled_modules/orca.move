module 0x48c14e5ac32c35e2225d837ef846f099a2ed78b26a7e7184365ddb3fcaada56a::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"ORCA", b"Orca", b"Introducing $ORCA the apex predator of memecoins on the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ORCA_LOGO_76a080d13f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

