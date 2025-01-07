module 0x367b303fd66c68c17247eef479ce0c3679d7a309b264c6bde890f07506bc2214::helpmesui {
    struct HELPMESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELPMESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELPMESUI>(arg0, 6, b"Helpmesui", b"HelpmeSendsui", b"Help me to begin in sui please 0x8372ae020c5cb4d7b6e91625291848d778c5e7d09364e74202ece962e0aed485", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731315866321.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELPMESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELPMESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

