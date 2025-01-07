module 0xf9eb48bbe0bf3cc7c39f24a5abce7e933cbb723c3da7469a1d9a6ef268eeb014::trd {
    struct TRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRD>(arg0, 6, b"TRD", b"TIRED", b"Just tired of everything !!! i am not a dev, i am just trying to create a coin, that's all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736259115446.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

