module 0x2233018fb5488801642d77e7a7a1aaf052d9a4c1e15c73f1db8997fd4af8a1dc::suiniper {
    struct SUINIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIPER>(arg0, 6, b"SUINIPER", b"Sui Sniper", b"$SUINIPER is your secret weapon in the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_77_794cec48a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

