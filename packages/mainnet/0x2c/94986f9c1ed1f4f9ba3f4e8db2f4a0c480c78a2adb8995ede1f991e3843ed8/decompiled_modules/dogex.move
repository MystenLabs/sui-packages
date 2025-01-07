module 0x2c94986f9c1ed1f4f9ba3f4e8db2f4a0c480c78a2adb8995ede1f991e3843ed8::dogex {
    struct DOGEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEX>(arg0, 6, b"DogeX", b"DEPT OF GOV EFFCY", b"New $DOGE X account created by Elon Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731552914423.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

