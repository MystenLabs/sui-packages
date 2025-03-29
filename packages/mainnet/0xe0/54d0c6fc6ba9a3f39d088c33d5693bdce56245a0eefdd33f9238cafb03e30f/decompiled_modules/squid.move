module 0xe054d0c6fc6ba9a3f39d088c33d5693bdce56245a0eefdd33f9238cafb03e30f::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 9, b"SQUID", b"USQUID", b"help for us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a72796c629d314061aa47744b84cb3e2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

