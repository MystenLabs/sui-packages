module 0x27a909b02ca89168aa30e610374a8bb220049841ae240c2edd53e379f2cb414c::kfg {
    struct KFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFG>(arg0, 6, b"KFG", b"LFG", b"abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_87cd451ada.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

