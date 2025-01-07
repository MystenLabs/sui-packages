module 0x3a4c38e06417885fc8422ba87ffcda69a365930d06a683857c7c9fe84bfd31a1::gangs {
    struct GANGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGS>(arg0, 6, b"GANGS", b"Sui Gangs", b"https://x.com/SuiGangs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hi7o_RL_Mh_400x400_18de236685.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GANGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

