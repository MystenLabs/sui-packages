module 0x81242efa6e5b6a9ab7ce8a3039c81f820063c4e79dfb7ebf1b51f6055a2081ec::froggnratt {
    struct FROGGNRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGNRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGNRATT>(arg0, 6, b"FroggnRatt", b"FroggnRatt SUI", b"FroggnRatt meme on sui chain lfg with FroggnRatt. PUMPPPP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x31348f17429e6b37ed269cc667cc83947ff8c54593dcbd1a56cae06a895a38be_fratt_fratt_04c19fb928.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGNRATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGNRATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

