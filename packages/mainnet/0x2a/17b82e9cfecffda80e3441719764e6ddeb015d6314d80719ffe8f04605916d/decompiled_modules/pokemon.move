module 0x2a17b82e9cfecffda80e3441719764e6ddeb015d6314d80719ffe8f04605916d::pokemon {
    struct POKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMON>(arg0, 6, b"Pokemon", b"Pokemon  Sui", b"The two Pokemon clashed, their movements fluid and precise. Luna's strategy proved successful, and Suicune yielded.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000093318_ab587b5d43.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

