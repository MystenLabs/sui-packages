module 0x2e59ba3fac9415604b7112b397676b1d2cf9e650eb91b5c358ff0f1869973337::suiple {
    struct SUIPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPLE>(arg0, 6, b"Suiple", b"Suiple Drop", b"Suiple droplet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_6_16cfe8c103.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

