module 0x505c4b3e1921f64b4afcc2154dd408a9cd29eff34387d30d469ecf4b33f7a630::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 9, b"GOKU", b"Goku Sayan", b"Super Sayan SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1388e7574bd4648eaf257dde9be239b0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

