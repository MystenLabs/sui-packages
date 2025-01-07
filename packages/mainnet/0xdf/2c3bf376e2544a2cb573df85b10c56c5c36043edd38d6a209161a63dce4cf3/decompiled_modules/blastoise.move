module 0xdf2c3bf376e2544a2cb573df85b10c56c5c36043edd38d6a209161a63dce4cf3::blastoise {
    struct BLASTOISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTOISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTOISE>(arg0, 6, b"BLASTOISE", b"Blasuitoise", b"Blasuitoise is notable for being the final evolution stage of one of the original starter Pokmon, along with Venusaur and Charizard. It has a Mega Evolution, available in Generation 6 games and Pokmon Go; it also has a Gigantamax form available in Pokmon Sword/Shield, with an exclusive G-Max move, G-Max Cannonade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_29_21_34_19_e8028cb008.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTOISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLASTOISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

