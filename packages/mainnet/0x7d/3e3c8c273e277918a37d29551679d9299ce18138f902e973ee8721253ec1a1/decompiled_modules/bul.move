module 0x7d3e3c8c273e277918a37d29551679d9299ce18138f902e973ee8721253ec1a1::bul {
    struct BUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUL>(arg0, 6, b"BUL", b"Bul", b"At $BUL, were not just another token on the blockwere a powerhouse community of bulls on a moon mission! Join the charge, theres no bulrun without the $bul.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bul_Logo_a8defb9c8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

