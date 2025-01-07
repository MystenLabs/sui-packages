module 0x555dafdcb92a8b35e716fd09c0bf2bde966c80a93e379c7b6418de95b8ce4b28::COOLKY {
    struct COOLKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<COOLKY>, arg1: 0x2::coin::Coin<COOLKY>) {
        0x2::coin::burn<COOLKY>(arg0, arg1);
    }

    fun init(arg0: COOLKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLKY>(arg0, 6, b"COOL", b"COOLKY", b"Coolky $SUI, the meme bull on the Sui chain! He's here to bring the bullish energy and good vibes to the blockchain world. TELEGRAM : https://t.me/coolkysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/fNX2R0d/cool.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOLKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COOLKY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COOLKY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

