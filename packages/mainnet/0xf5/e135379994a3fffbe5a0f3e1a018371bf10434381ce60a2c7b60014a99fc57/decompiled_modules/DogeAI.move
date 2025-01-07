module 0xf5e135379994a3fffbe5a0f3e1a018371bf10434381ce60a2c7b60014a99fc57::DogeAI {
    struct DOGEAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGEAI>, arg1: 0x2::coin::Coin<DOGEAI>) {
        0x2::coin::burn<DOGEAI>(arg0, arg1);
    }

    fun init(arg0: DOGEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEAI>(arg0, 2, b"DogeAI", b"Sui DogeAI", b"DogeAI on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arbdoge.ai/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGEAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGEAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

