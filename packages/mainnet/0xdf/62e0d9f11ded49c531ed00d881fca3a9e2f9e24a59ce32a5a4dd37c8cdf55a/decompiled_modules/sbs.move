module 0xdf62e0d9f11ded49c531ed00d881fca3a9e2f9e24a59ce32a5a4dd37c8cdf55a::sbs {
    struct SBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBS>(arg0, 6, b"SBS", b"SUIBOSS", b"OFFICIAL BOSS OF SUI Adeniyi.sui MEME! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boss_c25f6a60bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

