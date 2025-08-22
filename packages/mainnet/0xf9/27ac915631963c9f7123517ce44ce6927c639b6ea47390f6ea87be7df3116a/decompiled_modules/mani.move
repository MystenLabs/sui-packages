module 0xf927ac915631963c9f7123517ce44ce6927c639b6ea47390f6ea87be7df3116a::mani {
    struct MANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANI>(arg0, 6, b"MANI", b"MANIFEST", b"Manifest the life of your dreams. Now on Moonbags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_l1200_49ac0f3c10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANI>>(v1);
    }

    // decompiled from Move bytecode v6
}

