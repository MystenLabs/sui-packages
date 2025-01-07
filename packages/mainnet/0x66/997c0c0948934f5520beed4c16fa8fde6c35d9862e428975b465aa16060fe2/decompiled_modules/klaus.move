module 0x66997c0c0948934f5520beed4c16fa8fde6c35d9862e428975b465aa16060fe2::klaus {
    struct KLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUS>(arg0, 9, b"KLAUS", b"KLAUS", b"AMERICAN DAD FISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.petmag.com.br/app/uploads/petteca/famosos/8677/klaus-03.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KLAUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

