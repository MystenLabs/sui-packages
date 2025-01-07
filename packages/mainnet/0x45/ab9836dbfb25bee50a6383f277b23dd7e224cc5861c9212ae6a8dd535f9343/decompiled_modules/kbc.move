module 0x45ab9836dbfb25bee50a6383f277b23dd7e224cc5861c9212ae6a8dd535f9343::kbc {
    struct KBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBC>(arg0, 6, b"KBC", b"KEYBOARD CAT", b"KEYBOARd cat meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fatso_593525c600.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

