module 0xc3074c311b5fbc5563f9f3a9ca71e23a20c2b7a6855ad56e3e7fb34b82648386::js_pool {
    struct JS has drop {
        dummy_field: bool,
    }

    entry fun create_pool(arg0: 0x2::coin::Coin<0x943fab9df355573935cf3e619583ec835c16350858fd746abed83de37dc1bde8::js_coin::JS_COIN>, arg1: 0x2::coin::Coin<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = JS{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc3074c311b5fbc5563f9f3a9ca71e23a20c2b7a6855ad56e3e7fb34b82648386::js_swap::LSP<JS, 0x943fab9df355573935cf3e619583ec835c16350858fd746abed83de37dc1bde8::js_coin::JS_COIN, 0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>>>(0xc3074c311b5fbc5563f9f3a9ca71e23a20c2b7a6855ad56e3e7fb34b82648386::js_swap::create_pool<JS, 0x943fab9df355573935cf3e619583ec835c16350858fd746abed83de37dc1bde8::js_coin::JS_COIN, 0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>(v0, arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

