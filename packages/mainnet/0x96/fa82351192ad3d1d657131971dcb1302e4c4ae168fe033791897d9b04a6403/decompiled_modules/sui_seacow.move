module 0x96fa82351192ad3d1d657131971dcb1302e4c4ae168fe033791897d9b04a6403::sui_seacow {
    struct SUI_SEACOW has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_SEACOW>, arg1: 0x2::coin::Coin<SUI_SEACOW>) {
        0x2::coin::burn<SUI_SEACOW>(arg0, arg1);
    }

    fun init(arg0: SUI_SEACOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SEACOW>(arg0, 9, b"SEACOW", b"SUI Seacow", b"https://t.me/+jRzLa5HkUY5hOTk1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1850992241998692352/KKCEGxwK_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_SEACOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SEACOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_SEACOW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_SEACOW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

