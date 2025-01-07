module 0x6e20bed95cbce9eda8ebc513e515f8b69cb604feae9f6a99c4a18f3d5a4ea741::CLOAK {
    struct CLOAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOAK>(arg0, 9, b"CLOAK", b"$CLOAK", b"$CLOAK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1744247835879669761/hp_7Nm-0_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLOAK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLOAK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

