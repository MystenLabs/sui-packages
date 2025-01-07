module 0xbc75a58624c02e777b7c5c927909e103132967053b80a049428d60055d510ced::eww {
    struct EWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EWW>(arg0, 6, b"EWW", b"Even Water", b"Drink water to be healthy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_2_52ed110a5f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

