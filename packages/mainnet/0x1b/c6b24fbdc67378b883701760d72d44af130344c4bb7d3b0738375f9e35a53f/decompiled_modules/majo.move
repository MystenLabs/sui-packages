module 0x1bc6b24fbdc67378b883701760d72d44af130344c4bb7d3b0738375f9e35a53f::majo {
    struct MAJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJO>(arg0, 6, b"Majo", b"Majo", b"Majo pair launch on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyW8nWT7eDDDRgHCcvUwmjp6qaSzGpY4Iefg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAJO>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

