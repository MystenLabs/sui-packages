module 0x9903d388a00ee660ad168074602828a46698605175f1dd5d169a26ec48ac812c::squirtlsui {
    struct SQUIRTLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRTLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTLSUI>(arg0, 6, b"Squirtlsui", b"Suqirtle", b"sui on squirtle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carapuce_pokemon_9c68847650.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRTLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

