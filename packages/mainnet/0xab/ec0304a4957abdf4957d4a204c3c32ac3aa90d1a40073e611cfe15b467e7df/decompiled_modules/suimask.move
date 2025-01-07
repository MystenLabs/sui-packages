module 0xabec0304a4957abdf4957d4a204c3c32ac3aa90d1a40073e611cfe15b467e7df::suimask {
    struct SUIMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMASK>(arg0, 6, b"SUIMASK", b"Sui Mask Dog", b"The real dog on SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimask_35032aa4e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

