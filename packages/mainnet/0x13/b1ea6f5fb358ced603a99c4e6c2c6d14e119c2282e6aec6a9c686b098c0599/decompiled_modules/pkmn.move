module 0x13b1ea6f5fb358ced603a99c4e6c2c6d14e119c2282e6aec6a9c686b098c0599::pkmn {
    struct PKMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKMN>(arg0, 9, b"PKMN", b"Pokemon Pokeball", b"Did it start in Kanto, or hundreds of years ago in Sinnoh, then called Hisui? Help solve the age old question with Pokeballs and other assorted items!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7533f72a96032bc30325e734470275b8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKMN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKMN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

