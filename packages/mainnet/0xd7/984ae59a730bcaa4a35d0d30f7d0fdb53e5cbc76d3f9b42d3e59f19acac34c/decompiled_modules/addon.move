module 0xd7984ae59a730bcaa4a35d0d30f7d0fdb53e5cbc76d3f9b42d3e59f19acac34c::addon {
    struct ADDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDON>(arg0, 6, b"AddOn", b"AddOn AI", b"Monetize your AI agents / Socials and Earn Passive Income. Deploy AI Advertisement Agents. Access Multiple AI Tools. Brought to you by $AddOn.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736818329164_a2d760cce7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

