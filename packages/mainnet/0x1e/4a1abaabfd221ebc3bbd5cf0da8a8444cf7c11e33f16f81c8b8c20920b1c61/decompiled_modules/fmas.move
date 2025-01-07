module 0x1e4a1abaabfd221ebc3bbd5cf0da8a8444cf7c11e33f16f81c8b8c20920b1c61::fmas {
    struct FMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMAS>(arg0, 9, b"FMAS", b"Merry Fricmas", b"Merry fricing FRICMAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/13881225bcb67c063587c5176fcedec9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

