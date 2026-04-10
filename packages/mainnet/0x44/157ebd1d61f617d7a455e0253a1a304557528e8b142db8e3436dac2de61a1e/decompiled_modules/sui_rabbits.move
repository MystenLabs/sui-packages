module 0x44157ebd1d61f617d7a455e0253a1a304557528e8b142db8e3436dac2de61a1e::sui_rabbits {
    struct SUI_RABBITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_RABBITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_RABBITS>(arg0, 9, b"Rabbits", b"Sui Rabbits", b"Sui rabbits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775801094354-1e010e1629b470a0915d6ed3fe3e2e6f.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_RABBITS>>(0x2::coin::mint<SUI_RABBITS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_RABBITS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_RABBITS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

