module 0xafb3e516e4be556f0f69955cd4051362d8b409a5c893f4a51fb0371f89f68a49::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<USDC>,
    }

    public fun burn(arg0: &mut Treasury, arg1: 0x2::coin::Coin<USDC>) {
        0x2::coin::burn<USDC>(&mut arg0.cap, arg1);
    }

    public fun mint(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::mint<USDC>(&mut arg0.cap, arg1, arg3), arg2);
        let v0 = MintEvent{
            recipient : arg2,
            amount    : arg1,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<USDC>(arg0, v0, b"USDC", b"USDC", b"Test USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<USDC>(&mut v3, 0x2::math::pow(10, v0 + 3), 0x2::tx_context::sender(arg1), arg1);
        let v4 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v3,
        };
        0x2::transfer::share_object<Treasury>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v2);
    }

    // decompiled from Move bytecode v6
}

