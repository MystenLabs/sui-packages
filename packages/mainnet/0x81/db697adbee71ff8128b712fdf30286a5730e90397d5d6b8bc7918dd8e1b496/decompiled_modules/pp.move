module 0x81db697adbee71ff8128b712fdf30286a5730e90397d5d6b8bc7918dd8e1b496::pp {
    struct PP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP>(arg0, 6, b"PP", b"Ping Ping", b"Wish the chart was green like bamboo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/quality_restoration_20250203170123517_3a473308d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PP>>(v1);
    }

    // decompiled from Move bytecode v6
}

