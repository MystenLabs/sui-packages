module 0x6fdc4b464a2bffb86398a1d3d5f84664378ac35c5598054564fc522c7ecc6072::had {
    struct HAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAD>(arg0, 9, b"HAD", b"haides AI", b"haides ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/ec84d9b217529a34e59eee37286700f8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

