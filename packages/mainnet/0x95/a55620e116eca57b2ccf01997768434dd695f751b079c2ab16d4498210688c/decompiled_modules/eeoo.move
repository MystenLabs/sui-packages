module 0x95a55620e116eca57b2ccf01997768434dd695f751b079c2ab16d4498210688c::eeoo {
    struct EEOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEOO>(arg0, 9, b"EEOO", b"HeHo", b"I am A ROBOT Hi my name is robot ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EEOO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEOO>>(v2, @0x8460005b0378efac468a1704d353afb8fa7e3d6743536d197c9d59f86809961e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

