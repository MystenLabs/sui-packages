module 0xc185f502752a157d8042d33d9b449536f270c5ade0ddd4eedc790732c8589d32::starriser {
    struct STARRISER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARRISER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARRISER>(arg0, 6, b"STARRISER", b"Star Riser", b"Start playing an Archero-like game in Telegram, upgrade your hero at every step, and see how far you can go!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000125_0f0fa07f6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARRISER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARRISER>>(v1);
    }

    // decompiled from Move bytecode v6
}

