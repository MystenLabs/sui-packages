module 0x79c33940a56794409f9f93850ecb8d74864f83382dd98e3da7f7cfe176db3e37::squirrel {
    struct SQUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SQUIRREL>(arg0, 6, b"SQUIRREL", b"Squirrel AI Agent by SuiAI", b"Jimmy the Squirrel is your high-tech eco-hero, tackling challenges and resolving any intellectual question you have with precision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_72095510c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIRREL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRREL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

