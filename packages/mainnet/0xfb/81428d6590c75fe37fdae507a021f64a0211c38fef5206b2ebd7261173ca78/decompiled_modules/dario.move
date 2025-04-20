module 0xfb81428d6590c75fe37fdae507a021f64a0211c38fef5206b2ebd7261173ca78::dario {
    struct DARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARIO>(arg0, 6, b"DARIO", b"Dario", b"$DARIO The only cryptocurrency you will HODL! Put $DARIO to work for you today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060147_1b7f77fc00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

