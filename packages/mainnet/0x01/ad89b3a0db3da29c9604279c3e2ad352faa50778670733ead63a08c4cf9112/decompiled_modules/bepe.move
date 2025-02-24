module 0x1ad89b3a0db3da29c9604279c3e2ad352faa50778670733ead63a08c4cf9112::bepe {
    struct BEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEPE>(arg0, 6, b"BEPE", b"Batman Pepe", b"\"I'm Batman... Pepe.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003312_a2e54325b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

