module 0x5bfa01523a9e09cca069616981f04a3d665b289c83b52394ceb37e08e4f7a8ec::bagc {
    struct BAGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGC>(arg0, 6, b"BAGC", b"BoredApe", b"Bored Ape Golf Club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bagc_7ae8318a39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

