module 0xe03ff74faccaa6e7c5b2e7e0c32c61ac0e24db9153a06f5bad0e200e89af9c6c::mhb {
    struct MHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHB>(arg0, 6, b"MHB", b"Muhulbabyce", b"100% Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760454305244.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

