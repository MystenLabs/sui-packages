module 0x883222cda817e5ecd2c027d69ba2f36cc915257d362d7c54fef42a555dfb0c32::scorn {
    struct SCORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCORN>(arg0, 6, b"SCORN", b"POPCORNONSUI", b"POPCORNONSUI is pure meme created on SUI network. No utilities nothing. Just fun and eat popcorn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965808686.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCORN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCORN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

