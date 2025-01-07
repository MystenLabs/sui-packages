module 0xc241798633f9bc9a70057ae5cb8f6657450f21bd356ccd9b8e151f76e6367900::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEGEN>, arg1: 0x2::coin::Coin<DEGEN>) {
        0x2::coin::burn<DEGEN>(arg0, arg1);
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 4, b"Degen Coin", b"DEGEN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.block-chain24.com/sites/default/files/crypto/pepe_pepe_coin_icon_256x256.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEGEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEGEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

