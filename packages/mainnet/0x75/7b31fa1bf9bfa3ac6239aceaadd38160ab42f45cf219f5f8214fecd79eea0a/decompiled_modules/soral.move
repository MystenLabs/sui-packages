module 0x757b31fa1bf9bfa3ac6239aceaadd38160ab42f45cf219f5f8214fecd79eea0a::soral {
    struct SORAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORAL>(arg0, 6, b"SORAL", b"SoralInu", b"BEST SORAL XD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soral_3b6b7dfd1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

