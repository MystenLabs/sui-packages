module 0x937cb8607269e5edbd0de93134a0822449bc7f99bf4a209e1a5fe53adb6a5160::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 9, b"BLAST", b"Blastoise", b"It crushes its foe under its heavy body to cause fainting. In a pinch, it will withdraw inside its shell.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/full//009.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLAST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

