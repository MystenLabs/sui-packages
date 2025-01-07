module 0xf36cf052f6df7a148ac21ce85ea102c534a1249336c69164a5ef8991d2b51105::hophip {
    struct HOPHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPHIP>(arg0, 6, b"HOPHIP", b"HOPHIP SUI", b"HopHip in da club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hophip_project_ee4ff9dd25.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

