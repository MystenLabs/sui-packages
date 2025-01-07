module 0xc9a65e1f6f5f71ff539537aad66230f154d2f150b8c2545d519a9391c64c1844::amigos {
    struct AMIGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMIGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMIGOS>(arg0, 6, b"AMIGOS", b"Amigos", b"The meme coin that's so laid-back, it's practically horizontal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731088809146.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMIGOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMIGOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

