module 0x8368f7a3d7d5df0df74cd2dd24a7bd30b84610de55c731a4dc9fbb3c981010c4::popol {
    struct POPOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPOL>(arg0, 9, b"POPOL", b"POPOL", b"Be ready! Something BIG is coming...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/HxrpR1sg/popol250.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPOL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

