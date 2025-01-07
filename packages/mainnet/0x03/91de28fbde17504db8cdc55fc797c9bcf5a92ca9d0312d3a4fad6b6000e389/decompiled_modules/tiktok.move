module 0x391de28fbde17504db8cdc55fc797c9bcf5a92ca9d0312d3a4fad6b6000e389::tiktok {
    struct TIKTOK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TIKTOK>, arg1: 0x2::coin::Coin<TIKTOK>) {
        0x2::coin::burn<TIKTOK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TIKTOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TIKTOK>>(0x2::coin::mint<TIKTOK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TIKTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKTOK>(arg0, 9, b"tiktok", b"TIKTOK", b"testing ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKTOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKTOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

