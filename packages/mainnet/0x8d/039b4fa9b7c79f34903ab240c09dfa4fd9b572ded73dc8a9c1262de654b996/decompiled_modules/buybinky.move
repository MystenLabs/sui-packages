module 0x8d039b4fa9b7c79f34903ab240c09dfa4fd9b572ded73dc8a9c1262de654b996::buybinky {
    struct BUYBINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYBINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUYBINKY>(arg0, 6, b"BUYBINKY", b"Buy BINKY", b"JOIN TG LINKED IN SOCIALS AND LETS BINK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_10e9ded567.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYBINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUYBINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

