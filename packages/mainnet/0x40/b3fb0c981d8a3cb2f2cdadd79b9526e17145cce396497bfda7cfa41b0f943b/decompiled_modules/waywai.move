module 0x40b3fb0c981d8a3cb2f2cdadd79b9526e17145cce396497bfda7cfa41b0f943b::waywai {
    struct WAYWAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAYWAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAYWAI>(arg0, 9, b"WAYWAI", b"WAYWAI MEME", b"waywal token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0d635d9d1fb28473cc49e3bbd49106a3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAYWAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAYWAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

