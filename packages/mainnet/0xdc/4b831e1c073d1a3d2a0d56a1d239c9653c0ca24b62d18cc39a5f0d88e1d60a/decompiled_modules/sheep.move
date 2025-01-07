module 0xdc4b831e1c073d1a3d2a0d56a1d239c9653c0ca24b62d18cc39a5f0d88e1d60a::sheep {
    struct SHEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEP>(arg0, 9, b"SHEEP", b"SHEEP", b"OBEJI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/png-clipart/20231016/original/pngtree-funny-sheep-shows-tongue-png-image_13324150.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHEEP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

