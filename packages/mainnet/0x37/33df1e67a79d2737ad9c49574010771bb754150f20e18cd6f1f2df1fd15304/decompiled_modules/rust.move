module 0x3733df1e67a79d2737ad9c49574010771bb754150f20e18cd6f1f2df1fd15304::rust {
    struct RUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUST>(arg0, 9, b"RUST", b"Rustam coin", b"my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b3b3d65983277e2610289850e99c2d1ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

