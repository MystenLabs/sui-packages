module 0xaa68ed3d0a36879fd27a536eff3da5e2da3eeab16bdee074c48ab16469ab6274::puca {
    struct PUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCA>(arg0, 6, b"PUCA", b"PUCA On Sui", b"Hi, my name's PUCA  I'm a cat and I'm purple, purr.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_7058325bf9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

