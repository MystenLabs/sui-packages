module 0xb28a85a5b2231b10425bb79960a206c0115b452e7c7939cb51479ba601b40dfc::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAIN>>(0x2::coin::mint<MAIN>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN>(arg0, 9, b"MAIN", b"Mainnet", b"sdf sadfsdf asdfdsf dsafds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dauxqsewoalgiarchiky.supabase.co/storage/v1/object/public/drop-images/7d7975d7-ed49-473b-b07b-54c9b43e0e4c.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MAIN>>(0x2::coin::mint<MAIN>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

