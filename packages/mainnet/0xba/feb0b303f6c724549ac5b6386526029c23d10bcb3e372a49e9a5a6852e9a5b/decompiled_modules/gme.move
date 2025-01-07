module 0xbafeb0b303f6c724549ac5b6386526029c23d10bcb3e372a49e9a5a6852e9a5b::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"Gamestop", b"GME to the moon;  join the movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733848602264.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

