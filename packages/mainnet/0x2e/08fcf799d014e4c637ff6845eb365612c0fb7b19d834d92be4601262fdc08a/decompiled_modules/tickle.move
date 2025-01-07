module 0x2e08fcf799d014e4c637ff6845eb365612c0fb7b19d834d92be4601262fdc08a::tickle {
    struct TICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKLE>(arg0, 6, b"TICKLE", b"Tickle Sui", b"They call me $TICKLE. Your best red friend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_ddc138e5cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

