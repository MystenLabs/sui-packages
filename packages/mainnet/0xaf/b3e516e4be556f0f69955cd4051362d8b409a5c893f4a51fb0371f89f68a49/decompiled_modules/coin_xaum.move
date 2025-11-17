module 0xafb3e516e4be556f0f69955cd4051362d8b409a5c893f4a51fb0371f89f68a49::coin_xaum {
    struct COIN_XAUM has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct GlobalMintCap has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<COIN_XAUM>,
    }

    public fun burn(arg0: &mut GlobalMintCap, arg1: 0x2::coin::Coin<COIN_XAUM>) {
        0x2::coin::burn<COIN_XAUM>(&mut arg0.treasury_cap, arg1);
    }

    public fun mint(arg0: &mut GlobalMintCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN_XAUM>>(0x2::coin::mint<COIN_XAUM>(&mut arg0.treasury_cap, arg1, arg3), arg2);
        let v0 = MintEvent{
            recipient : arg2,
            amount    : arg1,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: COIN_XAUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_XAUM>(arg0, 9, b"XAUM", b"XAUM Token", b"XAUM is the primary token for staking and earning rewards - Test Version (Anyone can mint)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/xaum-icon.png")), arg1);
        let v2 = GlobalMintCap{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_XAUM>>(v1);
        0x2::transfer::share_object<GlobalMintCap>(v2);
    }

    // decompiled from Move bytecode v6
}

