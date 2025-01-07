module 0xe53462d4804d7c4612cdb6ffbc6ae8e20d7f20bd976b8559127c8dbcde04fa51::suq {
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

