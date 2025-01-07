module 0xdbaa113c22f124456319d2322ab6e3fe72fa43b1eaf6d0170e626cea36817a7a::MIKU {
    struct MIKU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MIKU>, arg1: 0x2::coin::Coin<MIKU>) {
        0x2::coin::burn<MIKU>(arg0, arg1);
    }

    fun init(arg0: MIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKU>(arg0, 9, b"MIKU", b"Suimiku", b"Suimiku is a memecoin that idolizes the goddess Hatsune Miku. Please join if you are interested or simply looking for an opportunity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/BByj0HB/miku.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIKU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MIKU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

