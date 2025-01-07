module 0x397e525680e77587ff6da8e15bc09eecb20bd2ba1c14587bd6dedb77bfa14799::jitosol {
    struct JITOSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JITOSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JITOSOL>(arg0, 9, b"JITOSOL", b"Foreign token represent Jito Staked SOL", b"Foreign token represent Jito Staked SOL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JITOSOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JITOSOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

