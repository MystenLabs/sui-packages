module 0x8ebc34fd5ae76e57139186a93a14d7fd739d902a3729d9e16e6dd8f518fa1b2e::joan {
    struct JOAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOAN>(arg0, 6, b"Joan", b"Sui Joan", b"Sui Joan, let's show this great artist how cool Sui is", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_21_T094956_599_4dcf414728.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

