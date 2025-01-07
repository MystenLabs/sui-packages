module 0xc296822f898f470fec40ee8bc0b6e159c9a792224a51492763fde687a617657f::gopnik {
    struct GOPNIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOPNIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOPNIK>(arg0, 6, b"GOPNIK", b"Sui Gopnik", b"Cool Frog is gopnik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012349_6987a432ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOPNIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOPNIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

