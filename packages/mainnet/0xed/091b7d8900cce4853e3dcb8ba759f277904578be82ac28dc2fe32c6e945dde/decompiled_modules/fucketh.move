module 0xed091b7d8900cce4853e3dcb8ba759f277904578be82ac28dc2fe32c6e945dde::fucketh {
    struct FUCKETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKETH>(arg0, 9, b"FUCKETH", b"Fuck Ethereum", b"Fuck ethereum official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUCKETH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKETH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

