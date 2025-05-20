module 0x241b8bd9638a720d5a5a09306bd5085494b41132c3030ce4887b59c5a9a8bb3f::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 6, b"FIGHT", b"FIGHTFIGHT", b"FIGHT DON BUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747753323829.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

