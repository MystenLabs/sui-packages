module 0xe41098a8973b11396e61c526903ce85d4042cb4b6ea1c6467e529327963cc5cf::sili {
    struct SILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILI>(arg0, 6, b"SILI", b"SUI SILI", b"Hey im Sili On turbos - Join telegram : https://t.me/suisiliportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967348388.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

