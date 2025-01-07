module 0xe989133ddcf49e0915400c99c1a899dfcec303e554f6cb5422b4144e4dfa2db::bnut {
    struct BNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNUT>(arg0, 6, b"BNUT", b"Brett the Squirrel", b"Brett the Squirrel - AKA BNUT stands immortalised on the blockchain forever, spearheading a movement that demands reform to current Governmental overreach. Long live BNUT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_8_8f399371da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

