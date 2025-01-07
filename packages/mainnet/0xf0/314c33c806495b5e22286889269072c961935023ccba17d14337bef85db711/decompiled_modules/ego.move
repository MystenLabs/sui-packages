module 0xf0314c33c806495b5e22286889269072c961935023ccba17d14337bef85db711::ego {
    struct EGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGO>(arg0, 9, b"EGO", b"EGOIST", b"EGOIST Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EGO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

