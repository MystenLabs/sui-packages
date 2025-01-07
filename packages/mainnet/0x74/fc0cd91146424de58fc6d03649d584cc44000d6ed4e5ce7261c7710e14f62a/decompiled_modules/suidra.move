module 0x74fc0cd91146424de58fc6d03649d584cc44000d6ed4e5ce7261c7710e14f62a::suidra {
    struct SUIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRA>(arg0, 6, b"SUIDRA", b"Suidra", b" $SUIDRA: Inspired by the legendary Pokmon of the seas! Evolving memes, strong community, and tidal waves of opportunity.  #SeadraCoin #CatchTheWave\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Seadra_Pokemon_Transparent_Images_20cbf08a53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

