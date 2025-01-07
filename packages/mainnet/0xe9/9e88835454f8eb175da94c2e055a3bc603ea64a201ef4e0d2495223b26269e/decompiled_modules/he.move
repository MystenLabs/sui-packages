module 0xe99e88835454f8eb175da94c2e055a3bc603ea64a201ef4e0d2495223b26269e::he {
    struct HE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HE>(arg0, 6, b"He", b"he", b"Hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953662250.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

