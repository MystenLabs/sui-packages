module 0x3a6ad7a8421f36ad4365c2ab8649505afda84a62fa987c4d88ed54f3e54e23b1::alpha_ai {
    struct ALPHA_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA_AI>(arg0, 9, b"ALPHA AI", b"Alpha AI", b"Alpha Ai Good Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776642285924-3507df9fddcfe3dd1aaf72d2ce0ae87d.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ALPHA_AI>>(0x2::coin::mint<ALPHA_AI>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHA_AI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA_AI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

