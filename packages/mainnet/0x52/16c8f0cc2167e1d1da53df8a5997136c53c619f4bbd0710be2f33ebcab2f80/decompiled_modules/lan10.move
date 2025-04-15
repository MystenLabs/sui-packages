module 0x5216c8f0cc2167e1d1da53df8a5997136c53c619f4bbd0710be2f33ebcab2f80::lan10 {
    struct LAN10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN10>(arg0, 9, b"LAN10", b"LAN0010", b"0010", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgxeVe7t2jOXvcOTqU95qE2rDwj6-kfcZWpg&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN10>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN10>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN10>>(v2);
    }

    // decompiled from Move bytecode v6
}

