module 0x2e7186c4803f4d1754883412320fa9f5cc7c11ee26251586783582a1e7074059::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, b"MYCOIN", b"my coin", b"wow this is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dauxqsewoalgiarchiky.supabase.co/storage/v1/object/public/drop-images/ea18bf38-6922-4052-a212-28d51a845116.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

