module 0x6f61457c47907ab86c863b2bd7fb8ffa81de29b8b8ab811c3df9b06c927f9a6a::zzww {
    struct ZZWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZWW>(arg0, 6, b"ZZWW", b"Zigga Zigga wha what", b"Zigga Zigga wha what is a Zigga Zigga token that is not only a Zigga Zigga token but also a Zigga Zigga token , so can i get a wha what for this Zigga Zigga token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zzww_667f256c6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

