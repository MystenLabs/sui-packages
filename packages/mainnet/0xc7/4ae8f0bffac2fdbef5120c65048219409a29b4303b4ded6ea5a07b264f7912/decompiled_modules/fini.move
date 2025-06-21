module 0xc74ae8f0bffac2fdbef5120c65048219409a29b4303b4ded6ea5a07b264f7912::fini {
    struct FINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINI>(arg0, 6, b"FINI", b"Infinity", b"Infinity is a token that gives you a second chance. Ever thought you were running out of time, well what if you could buy more. Making money and having fun both takes time, and time can be finite and infinite. Now is the time to make it count. Now is", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750485440437.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FINI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

