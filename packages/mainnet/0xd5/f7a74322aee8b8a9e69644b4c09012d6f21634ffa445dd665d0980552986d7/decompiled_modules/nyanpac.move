module 0xd5f7a74322aee8b8a9e69644b4c09012d6f21634ffa445dd665d0980552986d7::nyanpac {
    struct NYANPAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYANPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYANPAC>(arg0, 6, b"NyanPac", b"NyanPacmoon", b"just launched new meta on turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963915949.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYANPAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYANPAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

