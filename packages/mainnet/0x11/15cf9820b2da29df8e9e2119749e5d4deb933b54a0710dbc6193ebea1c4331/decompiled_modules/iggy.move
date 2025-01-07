module 0x1115cf9820b2da29df8e9e2119749e5d4deb933b54a0710dbc6193ebea1c4331::iggy {
    struct IGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGGY>(arg0, 2, b"IGGY", b"Sister Iggy", b"Sister of Mother Iggy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file.coinexstatic.com/2024-05-29/A4EC9736DD8F5528D3754E335046F118.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IGGY>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

