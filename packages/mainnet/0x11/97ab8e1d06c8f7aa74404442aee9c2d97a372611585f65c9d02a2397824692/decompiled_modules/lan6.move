module 0x1197ab8e1d06c8f7aa74404442aee9c2d97a372611585f65c9d02a2397824692::lan6 {
    struct LAN6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN6>(arg0, 9, b"LAN6", b"LAN006", b"006", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGXpNfIdWbtbvL4Nu5aZCEHcHWH-w8OVHoqQ&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN6>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN6>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN6>>(v2);
    }

    // decompiled from Move bytecode v6
}

