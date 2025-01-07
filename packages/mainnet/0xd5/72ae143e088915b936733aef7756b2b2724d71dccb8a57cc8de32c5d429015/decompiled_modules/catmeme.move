module 0xd572ae143e088915b936733aef7756b2b2724d71dccb8a57cc8de32c5d429015::catmeme {
    struct CATMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMEME>(arg0, 6, b"Catmeme", b"MEME", b"Cat is cute <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.hydropump.xyz/logo/01JCGENVPTMJWF3GDK1S2H9WJ7/01JCGER5BPRWXJKFFXFHDM3WY6")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

