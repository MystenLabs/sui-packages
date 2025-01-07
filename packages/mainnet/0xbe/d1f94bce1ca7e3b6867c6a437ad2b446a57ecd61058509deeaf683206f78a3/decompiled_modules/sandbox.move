module 0xbed1f94bce1ca7e3b6867c6a437ad2b446a57ecd61058509deeaf683206f78a3::sandbox {
    struct SANDBOX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SANDBOX>, arg1: 0x2::coin::Coin<SANDBOX>) {
        0x2::coin::burn<SANDBOX>(arg0, arg1);
    }

    fun init(arg0: SANDBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDBOX>(arg0, 6, b"SANDBOX", b"The Sandbox", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/3RsQMZ5/sandbox.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANDBOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDBOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SANDBOX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SANDBOX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

