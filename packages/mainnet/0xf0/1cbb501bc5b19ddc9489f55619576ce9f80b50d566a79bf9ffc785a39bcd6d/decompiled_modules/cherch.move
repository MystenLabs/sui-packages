module 0xf01cbb501bc5b19ddc9489f55619576ce9f80b50d566a79bf9ffc785a39bcd6d::cherch {
    struct CHERCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHERCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHERCH>(arg0, 6, b"CHeRCH", b"CHeRCH SUI", b"Just a church. Seriously. A plain old church. Nothing sinister or possibly evil lurking under the surface. We swear. Religion has been around since the dawn of time. Welcome to CHeRCH, a multi-cycle cult meme coin. What could go wrong?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7700_fa7483af2e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHERCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHERCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

