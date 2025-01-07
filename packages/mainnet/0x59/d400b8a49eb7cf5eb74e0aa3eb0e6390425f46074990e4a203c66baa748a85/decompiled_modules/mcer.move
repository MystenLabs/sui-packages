module 0x59d400b8a49eb7cf5eb74e0aa3eb0e6390425f46074990e4a203c66baa748a85::mcer {
    struct MCER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCER>(arg0, 6, b"MCER", b"MC EREN", b"here's your deluxe meal with a cheesburger,extra sauce,mc flurry side-salad,i don't believe you will eat that by looking at you and a side of fries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/91d2628bcd0fc7fb89954fba4afe5e5a_6c33b202aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCER>>(v1);
    }

    // decompiled from Move bytecode v6
}

