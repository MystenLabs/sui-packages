module 0x1c54e350fc3ddd9a318134517fec4a95b5220c00491b9fe388d66600e6d4fc8c::shlaaagbag {
    struct SHLAAAGBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHLAAAGBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHLAAAGBAG>(arg0, 9, b"SHLAAAG BAG", b"SHLAAAGBAG", b"SHLLLLAAAAAG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1759938448/sui_tokens/hrmlttvkydavjwrkfgmq.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SHLAAAGBAG>>(0x2::coin::mint<SHLAAAGBAG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHLAAAGBAG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHLAAAGBAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

