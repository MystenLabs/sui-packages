module 0xc98b7614edc03bae3d864f8b77ff64656b91e016b64bb5c5491ba90f810eec28::leepy {
    struct LEEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEEPY>(arg0, 6, b"LEEPY", b"Leepy", b"Leepy's a simple, clueless pigeon, always looking dazed and confused. It spends all day asking, Who am I? Why am I here?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/leepy_logo_935f604d7e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEEPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

