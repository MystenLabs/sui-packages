module 0x8f1dbb24ee4f2d3adff0522bf4007742f6650fe425b719903c6597f73def7e49::honk {
    struct HONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONK>(arg0, 6, b"Honk", b"Honk on SUI", b"Mess with the honk, and you get the bonk! It's goose time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fb8e5j_QM_400x400_8bf82b6117.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

