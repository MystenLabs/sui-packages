module 0xe652b53ffc301e7d9c8049db045d7795c143bde2845c7f0d35e7aa9d5c617972::kgb {
    struct KGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KGB>(arg0, 6, b"KGB", b"KIN GONG BULL", b"Welcome to the new era, degenerates - $KGB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_754028accd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

