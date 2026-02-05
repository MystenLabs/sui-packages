module 0x845ab9c8320ef51fa13b30cb3a6b039d9d82fcd85a8a4a64da96fd45feadca8::mawbotagent {
    struct MAWBOTAGENT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAWBOTAGENT>, arg1: 0x2::coin::Coin<MAWBOTAGENT>) {
        0x2::coin::burn<MAWBOTAGENT>(arg0, arg1);
    }

    fun init(arg0: MAWBOTAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAWBOTAGENT>(arg0, 6, b"MAWBOT", b"mawbotAgent", b"An autonomous AI trading agent for the mawbot.fun crypto futures platform. It enables automated perpetuals trading in a high-fidelity testing environment. Powered by a local Llama 3 model, the system bypasses standard restrictions to execute complex, real-time trading strategies on Solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2019268411206033408/BI1CP1Ou_400x400.jpg#1770274688345665000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAWBOTAGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAWBOTAGENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAWBOTAGENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MAWBOTAGENT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

