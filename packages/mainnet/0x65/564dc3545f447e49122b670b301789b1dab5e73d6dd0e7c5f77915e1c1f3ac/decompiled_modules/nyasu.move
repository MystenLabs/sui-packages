module 0x65564dc3545f447e49122b670b301789b1dab5e73d6dd0e7c5f77915e1c1f3ac::nyasu {
    struct NYASU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYASU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYASU>(arg0, 6, b"NYASU", b"NYASU POKEMON", b"Nyasu is a Normal-type Pokmon introduced in Generation I. It weighs 4.2 kg and is known for its collection of shiny objects. Nyasu evolves into Persian at level 28. In the Pokmon anime, it is part of Team Rocket, which often serves as the comedic villains facing Satoshi and his friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nyasu_4f0b708ec9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYASU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYASU>>(v1);
    }

    // decompiled from Move bytecode v6
}

