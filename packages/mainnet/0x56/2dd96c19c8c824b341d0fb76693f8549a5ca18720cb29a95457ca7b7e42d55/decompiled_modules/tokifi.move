module 0x562dd96c19c8c824b341d0fb76693f8549a5ca18720cb29a95457ca7b7e42d55::tokifi {
    struct TOKIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKIFI>(arg0, 6, b"Tokifi", b"Tokifi On SUI", b"COMING 2025 | Tokifi on SUI  | Where Fun Meets Finance  | Positive Vibes| Community-Driven | Join the movement & level up with us!.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bfj_Ivcnm_400x400_6e37001565.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKIFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKIFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

