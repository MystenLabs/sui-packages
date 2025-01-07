module 0x86dc48e30efaa07bcae50a2f7dab7e925006317c4ab5b80bd30344faaee13f01::ti {
    struct TI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TI>(arg0, 9, b"TI", b"Tahiti", b"SUI Treasure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/6rHNJLX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TI>(&mut v2, 11111111000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TI>>(v1);
    }

    // decompiled from Move bytecode v6
}

