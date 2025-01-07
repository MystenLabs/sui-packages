module 0xe56a8c3e446c2e0bc562bbbac41f6e5a728267fa83a1527518a827c175cb6aba::vampire {
    struct VAMPIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAMPIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAMPIRE>(arg0, 6, b"VAMPIRE", b"Water Sucking Vampire", b"Thirsty for liquidity, $VAMPIRE prowls the Sui Network, draining every drop it finds. Slick and sly, this water-sucker is always hunting for the next juicy bite!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_73_ae163efaec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAMPIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAMPIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

