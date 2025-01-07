module 0xf3832d1ac01ad4f319f587a0137969bb3013398d9de0420e85f643ca789b955e::ms {
    struct MS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MS>(arg0, 9, b"MS", b"MagicianSui", b"=)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOvDYuVhFnWgObMgd7fPtR_yS7Oo8h1wop8w&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MS>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MS>>(v1);
    }

    // decompiled from Move bytecode v6
}

