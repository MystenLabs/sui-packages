module 0x48c906989214b82fa18866084de238f97ce65f0195c7901c1e3044529ca963da::joeger {
    struct JOEGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOEGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOEGER>(arg0, 6, b"JOEGER", b"Joeger Sui", b"JUST JOEGER NOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086650_d16432b61f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOEGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOEGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

