module 0xf2bf3273ab274e8840455e54355b7d9ba6ad09598669816207cdbd368f0e54b1::eddietang {
    struct EDDIETANG has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<EDDIETANG>, arg1: 0x2::coin::Coin<EDDIETANG>) {
        0x2::coin::burn<EDDIETANG>(arg0, arg1);
    }

    fun init(arg0: EDDIETANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDDIETANG>(arg0, 6, b"Eddietang", b"Eddietang", b"Eddietang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1879127889146466304/XFUDEdEw_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDDIETANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDDIETANG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<EDDIETANG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EDDIETANG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

