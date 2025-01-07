module 0x3da775a10293f0ddfd25bbc6fdc95236287a93813b34774b096f373203db5f4c::koban {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 9, b"KOBAN", b"Koban", b"An ecosystem token from Lucky Kat Studios - Powering the future of ownership in gaming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.prod.website-files.com/62752febd034035dea41c1ab/649962fc8938c8e1101ce725_-KOBAN%20coin%20(1)%20(1).png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KOBAN>>(0x2::coin::mint<KOBAN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KOBAN>>(v2);
    }

    // decompiled from Move bytecode v6
}

