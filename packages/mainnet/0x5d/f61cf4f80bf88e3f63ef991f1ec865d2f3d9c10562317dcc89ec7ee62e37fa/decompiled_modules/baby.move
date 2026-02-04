module 0x5df61cf4f80bf88e3f63ef991f1ec865d2f3d9c10562317dcc89ec7ee62e37fa::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BABY>, arg1: 0x2::coin::Coin<BABY>) {
        0x2::coin::burn<BABY>(arg0, arg1);
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY>(arg0, 9, b"baby", b"BabyKitty", b"baby kitty now its live on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://suicreate.com/uploads/logo_1770169919491_5a95f185.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

