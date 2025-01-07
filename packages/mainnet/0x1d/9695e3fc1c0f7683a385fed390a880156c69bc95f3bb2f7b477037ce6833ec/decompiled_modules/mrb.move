module 0x1d9695e3fc1c0f7683a385fed390a880156c69bc95f3bb2f7b477037ce6833ec::mrb {
    struct MRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRB>(arg0, 9, b"MRB", b"MrBurns", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tse1.mm.bing.net/th?id=OIP.H6tFw2Q1u7Y0cKiZXLjXrAHaGi&pid=Api&rs=1&c=1&qlt=95&w=138&h=121")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MRB>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

