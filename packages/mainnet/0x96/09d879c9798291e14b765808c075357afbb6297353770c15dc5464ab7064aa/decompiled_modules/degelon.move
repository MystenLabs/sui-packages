module 0x9609d879c9798291e14b765808c075357afbb6297353770c15dc5464ab7064aa::degelon {
    struct DEGELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGELON>(arg0, 6, b"DEGELON", b"DegElon", b"HE A DEGELON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732436756710.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

