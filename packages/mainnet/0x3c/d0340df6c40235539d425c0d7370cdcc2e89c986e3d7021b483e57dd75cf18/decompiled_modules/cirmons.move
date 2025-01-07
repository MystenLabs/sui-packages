module 0x3cd0340df6c40235539d425c0d7370cdcc2e89c986e3d7021b483e57dd75cf18::cirmons {
    struct CIRMONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRMONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIRMONS>(arg0, 6, b"CIRMONS", b"Sui Cirmons", b"$CIRMONS -  Adorable miniature monters !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_eb99e6a1b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIRMONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIRMONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

