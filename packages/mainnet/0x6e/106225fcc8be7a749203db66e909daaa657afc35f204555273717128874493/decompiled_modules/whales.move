module 0x6e106225fcc8be7a749203db66e909daaa657afc35f204555273717128874493::whales {
    struct WHALES has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHALES>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WHALES>>(0x2::coin::mint<WHALES>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: WHALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALES>(arg0, 9, b"WHALY", b"WHALES", b"WHALY a Sui Whales only coin is the performer that you waited for no small fishes allowed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1640281084767109120/138QF8w7_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHALES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHALES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALES>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

