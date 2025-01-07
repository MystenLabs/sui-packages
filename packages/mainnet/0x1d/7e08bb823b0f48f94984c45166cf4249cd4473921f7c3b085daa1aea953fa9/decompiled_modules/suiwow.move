module 0x1d7e08bb823b0f48f94984c45166cf4249cd4473921f7c3b085daa1aea953fa9::suiwow {
    struct SUIWOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOW>(arg0, 6, b"Suiwow", b"World of women", b"* \"WoW Token: Join the Global Community of Empowered Women! By purchasing a WoW Token, you're not only getting a unique digital asset, you're joining a dynamic and growing community of people who believe in empowering women. Every  The token is a step towards creating a more equal and inclusive world.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001175_865cad47fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

