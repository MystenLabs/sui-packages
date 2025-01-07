module 0x4efa29f4ef10fae0046357be81a5e1d19f759df17d5b9ff9a22891195f88c508::slop {
    struct SLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOP>(arg0, 6, b"SLOP", b"SLOP FUN", x"5469726564206f662064656c6179733f2043616e2774207761697420616e796d6f72653f2054696d6520666f7220534c4f502e200a0a534c4f502c20534c4f502c20534c4f50202e2e2e2023534c4f5046554e4c4f4c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SLOP_LOGO_11722004be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

