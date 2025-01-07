module 0x7907727d9ec55c301759d222df5d744746832425a8eadb8fd78455e393860eb4::YE {
    struct YE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YE>(arg0, 9, b"YE", b"Kanye Coin on SUI", b"$YE Kanye Coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746963931531247616/hEwiC_QB_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

