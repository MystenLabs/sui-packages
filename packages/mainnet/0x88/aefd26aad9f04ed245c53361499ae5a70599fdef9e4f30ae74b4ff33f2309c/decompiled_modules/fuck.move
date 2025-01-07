module 0x88aefd26aad9f04ed245c53361499ae5a70599fdef9e4f30ae74b4ff33f2309c::fuck {
    struct FUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCK>(arg0, 9, b"FUCK", b"FUCK IT", b"Fuck to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.shutterstock.com/image-vector/hand-gesture-fuck-you-symbol-600nw-2312064349.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUCK>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

