module 0x917205c135afd584309654a6137457f5d20ca9c9481b4c53f36dac9cf820d221::fbi {
    struct FBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBI>(arg0, 6, b"FBI", b"Frog Bureau of Investigation", b"The Frog Bureau of Investigation (FBI) investigates unusual decentralized cases and internal news in the meme community. The Bureau has special abilities in investigating cases of missing whales and unusual whitelist pre-sales.\"Frog agent with extraordinary long pumping ability protects the chart and help the community meme avoid the hidden bull traps of farmer devs or the panic wave of jeets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_3a5c838f8c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

