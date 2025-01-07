module 0x191b8daf9a8fbfc3a97546a2370343908776aef2f641bac7d34b1ef46fa4fbe1::arbs {
    struct ARBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARBS>(arg0, 9, b"ARBS", b"Arebbies", b"collection by berachain community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/181aa831b3988b3e8ecb949ec190ba3dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

