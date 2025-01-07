module 0x15fd92bd79943249e51d687858fe1d3aa20e36366ad2481d09c83b57778abba5::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAS>(arg0, 6, b"GAS", b"Fat guy runs", x"4761732c206761732c206761730a49276d20676f6e6e612073746570206f6e20746865206761730a546f6e696768742049276c6c20666c790a416e6420626520796f7572206c6f7665720a596561682c20796561682c20796561680a49276c6c20626520736f20717569636b206173206120666c6173680a416e642049276c6c20626520796f7572206865726f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GAS_Fat_guy_runs_c6daae9f7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

