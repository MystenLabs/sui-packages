module 0x4304b5e3a1e489aaa0b163518d8cb5c19cf9cc51a71b9da6a346098f1b415d42::meyo {
    struct MEYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEYO>(arg0, 6, b"MEYO", b"Meyo On Sui", b"while youre out and about searching for your next play, dont get meyo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055095_ee337ff32c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

