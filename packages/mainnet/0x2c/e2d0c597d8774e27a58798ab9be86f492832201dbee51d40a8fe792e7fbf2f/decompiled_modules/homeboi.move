module 0x2ce2d0c597d8774e27a58798ab9be86f492832201dbee51d40a8fe792e7fbf2f::homeboi {
    struct HOMEBOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMEBOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMEBOI>(arg0, 6, b"HOMEBOI", b"Homeboi Flicks", b"I JUST WANNA $HOMEBOI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053023_15c151d466.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMEBOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMEBOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

