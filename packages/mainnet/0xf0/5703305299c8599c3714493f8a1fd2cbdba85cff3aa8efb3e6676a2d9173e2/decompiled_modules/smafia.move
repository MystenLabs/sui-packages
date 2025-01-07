module 0xf05703305299c8599c3714493f8a1fd2cbdba85cff3aa8efb3e6676a2d9173e2::smafia {
    struct SMAFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAFIA>(arg0, 6, b"SMafia", b"Sui Mafia", b"Invest with Honor!Mafia Coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004608_b60f6a2195.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAFIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAFIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

