module 0x4669e64d99608448b011f04c61c51022a8bcc6e6d0a65bf13f0a67c422b4b97d::suq {
    struct SUQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUQ>(arg0, 6, b"SUQ", b"SuQuirtle", b"Suquirtle is a nostalgia community-driven meme designed to inject humor and creativity on the Sui Network. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_a66e81b4e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

