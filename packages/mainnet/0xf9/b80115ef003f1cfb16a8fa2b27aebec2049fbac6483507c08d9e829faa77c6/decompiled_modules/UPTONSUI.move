module 0xf9b80115ef003f1cfb16a8fa2b27aebec2049fbac6483507c08d9e829faa77c6::UPTONSUI {
    struct UPTONSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<UPTONSUI>, arg1: 0x2::coin::Coin<UPTONSUI>) {
        0x2::coin::burn<UPTONSUI>(arg0, arg1);
    }

    fun init(arg0: UPTONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPTONSUI>(arg0, 6, b"UTS", b"UPTONSUI", b"high-yield opportunities and achieve true financial equality! https://www.uptonfi.com/ https://x.com/upton_fi https://t.me/uptonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/YpMLbjz/photo-2024-10-16-00-21-56.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPTONSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPTONSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UPTONSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<UPTONSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

