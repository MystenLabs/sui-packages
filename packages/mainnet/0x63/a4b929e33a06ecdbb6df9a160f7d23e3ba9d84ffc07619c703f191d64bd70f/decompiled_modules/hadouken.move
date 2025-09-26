module 0x63a4b929e33a06ecdbb6df9a160f7d23e3ba9d84ffc07619c703f191d64bd70f::hadouken {
    struct HADOUKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HADOUKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HADOUKEN>(arg0, 9, b"HADOUKEN", b"RYU", b"Ryu's Hadouken (Street Fighter) 8-bit Retro Pixel Art.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758897225/sui_tokens/spzd2vyoudnmfkatgiy2.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HADOUKEN>>(0x2::coin::mint<HADOUKEN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HADOUKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HADOUKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

