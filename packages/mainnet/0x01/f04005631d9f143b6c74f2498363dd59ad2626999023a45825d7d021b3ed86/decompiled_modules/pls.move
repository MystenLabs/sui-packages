module 0x1f04005631d9f143b6c74f2498363dd59ad2626999023a45825d7d021b3ed86::pls {
    struct PLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLS>(arg0, 6, b"PLS", b"trytoken", b"pls dont buy im try", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img_dab7137d31.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

