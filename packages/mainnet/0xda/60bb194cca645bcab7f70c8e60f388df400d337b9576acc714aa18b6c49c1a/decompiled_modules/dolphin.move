module 0xda60bb194cca645bcab7f70c8e60f388df400d337b9576acc714aa18b6c49c1a::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOLPHIN>, arg1: 0x2::coin::Coin<DOLPHIN>) {
        0x2::coin::burn<DOLPHIN>(arg0, arg1);
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 9, b"dolphin", b"dolphin", b"X: https://x.com/DolphinOnSui Telegram: https://t.me/DolphinSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/FQHgwUu.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
        0x2::coin::mint_and_transfer<DOLPHIN>(&mut v2, 9600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOLPHIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOLPHIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

