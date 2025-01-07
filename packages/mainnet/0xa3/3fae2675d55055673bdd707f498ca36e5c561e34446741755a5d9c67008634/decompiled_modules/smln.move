module 0xa33fae2675d55055673bdd707f498ca36e5c561e34446741755a5d9c67008634::smln {
    struct SMLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMLN>(arg0, 6, b"SMLN", b"SUIMELON", b"GOOO Melon memeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/melon_2218147e62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

