module 0xfa37058eadf81fc1d993f684b9b76ba5228c1ed71890a7946b7dceaabdc1bbb2::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: 0x2::coin::Coin<USDC>) {
        0x2::coin::burn<USDC>(arg0, arg1);
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 9, b"USDC", b"USDC COIN", b"USDC is a US dollar-backed stablecoin issued by Circle. USDC is designed to provide a faster, safer, and more efficient way to send, spend, and exchange money around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.circle.com/hubfs/Brand/USDC/USDC_icon_32x32.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

