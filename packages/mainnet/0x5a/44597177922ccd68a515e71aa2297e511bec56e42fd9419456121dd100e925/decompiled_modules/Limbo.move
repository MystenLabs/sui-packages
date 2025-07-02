module 0x5a44597177922ccd68a515e71aa2297e511bec56e42fd9419456121dd100e925::Limbo {
    struct LIMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMBO>(arg0, 9, b"LIMBO", b"Limbo", b"just a lost boy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/1ceb34c0-0a87-4189-ae70-29117a3855a8.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

