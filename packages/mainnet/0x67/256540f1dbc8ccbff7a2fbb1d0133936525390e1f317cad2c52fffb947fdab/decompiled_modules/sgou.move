module 0x67256540f1dbc8ccbff7a2fbb1d0133936525390e1f317cad2c52fffb947fdab::sgou {
    struct SGOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOU>(arg0, 6, b"SGOU", b"GOU", b"Will people like this cool dog? There's no doubt that we're going to send him to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012764_b5674df7f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

