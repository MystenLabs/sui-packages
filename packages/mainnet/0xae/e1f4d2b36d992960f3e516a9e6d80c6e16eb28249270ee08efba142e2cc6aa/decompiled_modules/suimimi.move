module 0xaee1f4d2b36d992960f3e516a9e6d80c6e16eb28249270ee08efba142e2cc6aa::suimimi {
    struct SUIMIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMIMI>(arg0, 6, b"SUIMIMI", b"Suimimi", b"Suimimi dive deep into the sui, where every swim unveils a new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/instant_26_beaa28bfa9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

