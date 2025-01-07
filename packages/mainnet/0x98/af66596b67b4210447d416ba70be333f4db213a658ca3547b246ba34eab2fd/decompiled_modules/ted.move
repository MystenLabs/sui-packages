module 0x98af66596b67b4210447d416ba70be333f4db213a658ca3547b246ba34eab2fd::ted {
    struct TED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TED>(arg0, 6, b"TED", b"Ted the Bear", b"Hello, i am Ted!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953633704.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

