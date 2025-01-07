module 0xaaa71167c284a6e5220461cbc364cd8c618ab2789bc934ca5cf878c1d487b99::bbr {
    struct BBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBR>(arg0, 6, b"BBR", b"BIG BULL RUN", b"$BBR is it here?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_10_e6600b86b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

