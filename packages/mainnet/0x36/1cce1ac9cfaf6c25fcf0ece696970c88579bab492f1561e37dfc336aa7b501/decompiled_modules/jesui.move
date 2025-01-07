module 0x361cce1ac9cfaf6c25fcf0ece696970c88579bab492f1561e37dfc336aa7b501::jesui {
    struct JESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUI>(arg0, 6, b"JESUI", b"JESUI GOD", b"I am the creator, I am everywhere, believe in me and you will be rewarded. Sincerely, the creator.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_13_172356_7772f58baf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

