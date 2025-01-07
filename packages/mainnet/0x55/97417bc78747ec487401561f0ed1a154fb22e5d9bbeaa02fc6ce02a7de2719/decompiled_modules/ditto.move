module 0x5597417bc78747ec487401561f0ed1a154fb22e5d9bbeaa02fc6ce02a7de2719::ditto {
    struct DITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DITTO>(arg0, 6, b"Ditto", b"Ditto Sui", b"Ditto on SUI, Say Hi!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/sdfggfd_57b806fbe9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DITTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DITTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

