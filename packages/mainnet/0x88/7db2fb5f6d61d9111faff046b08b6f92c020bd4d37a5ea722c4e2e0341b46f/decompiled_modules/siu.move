module 0x887db2fb5f6d61d9111faff046b08b6f92c020bd4d37a5ea722c4e2e0341b46f::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"Siu", b"CriRo", b"SIUUUUUUUUUUUUUUUUUUUUUUUU!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949123498.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

