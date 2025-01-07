module 0x6ee6b21dc12675db3971d6e620a135541cd548648fde23922915604dbd0e94a1::pp_cat {
    struct PP_CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP_CAT>(arg0, 6, b"PP_Cat", b"Cat In PePe", b"Meet Cat in PePe, the cutest combination of feline charm and froggy whimsy! This orange tabby is rocking a vibrant green frog hat that perfectly complements its curious and playful personality. With its bright eyes and snug, cozy outfit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732620440511.14")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PP_CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP_CAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

