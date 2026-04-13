module 0x6665c4451f1fdfb56033b2c1bd86a07c4603166951830ba3a62c32c86930c0b2::baby_turbo {
    struct BABY_TURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY_TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY_TURBO>(arg0, 9, b"BABY TURBO", b"Baby Turbo", b"Baby Turbo Just Launched", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776081510292-229e11c04de776b762fa61c13cbf4bc4.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BABY_TURBO>>(0x2::coin::mint<BABY_TURBO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY_TURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY_TURBO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

