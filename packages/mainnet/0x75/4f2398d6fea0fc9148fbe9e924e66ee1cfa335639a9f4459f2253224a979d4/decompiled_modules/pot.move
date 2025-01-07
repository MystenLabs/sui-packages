module 0x754f2398d6fea0fc9148fbe9e924e66ee1cfa335639a9f4459f2253224a979d4::pot {
    struct POT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POT>(arg0, 6, b"POT", b"POT on SUI", b"Hi I'm Pot, made by my little brother who's autistic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z3_Zdtcq4_400x400_8b20d71752.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POT>>(v1);
    }

    // decompiled from Move bytecode v6
}

