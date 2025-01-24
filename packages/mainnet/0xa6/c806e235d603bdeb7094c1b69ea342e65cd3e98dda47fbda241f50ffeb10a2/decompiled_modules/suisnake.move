module 0xa6c806e235d603bdeb7094c1b69ea342e65cd3e98dda47fbda241f50ffeb10a2::suisnake {
    struct SUISNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISNAKE>(arg0, 6, b"SUISNAKE", b"SUI Snake AI by SuiAI", b"Welcome to SUI Snake AI.We build SUI Community just in time for the Year of the SNAKE.Come and join our X and TG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Leonardo_Anime_XL_a_snake_animal_chibi_skin_of_the_animal_is_2_684ea7fd75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISNAKE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISNAKE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

