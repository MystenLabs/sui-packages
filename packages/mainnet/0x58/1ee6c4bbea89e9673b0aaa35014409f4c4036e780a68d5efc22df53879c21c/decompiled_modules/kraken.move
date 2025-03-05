module 0x581ee6c4bbea89e9673b0aaa35014409f4c4036e780a68d5efc22df53879c21c::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"kraken", b"kraken meme", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/bbd87d72-3d28-448f-9214-a11f6ceda28b.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

