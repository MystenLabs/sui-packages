module 0x586b1380c1009ecfb8abb38dcf8b351ac1abfd1025333e38d3e67c3830b8a0f2::zetard {
    struct ZETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZETARD>(arg0, 6, b"ZETARD", b"Zombitardio", b"Meet Zombitardio... After a summer in the trenches without food or water and no sleep at all, $ZETARD turned into a retarded zombie. $ZETARD is the zombie trench warrior and now it's his time to rule.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/ppp_8f9f7342bf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZETARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZETARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

