module 0x74377691415325d25a4ea87b0e73cb9e1229798dd3feb320bb84018b52e85fe4::wncx {
    struct WNCX has drop {
        dummy_field: bool,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: 0x2::coin::Coin<WNCX>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WNCX>>(arg0, 0x2::address::from_bytes(x"deaddeaddeaddeaddeaddeaddeaddeaddeaddeaddeaddeaddeaddeaddeaddead"));
        let v0 = BurnEvent{amount: 0x2::coin::value<WNCX>(&arg0)};
        0x2::event::emit<BurnEvent>(v0);
    }

    fun init(arg0: WNCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNCX>(arg0, 6, b"WNCX", b"NanoWorldComix", b"The most creative multichain token, backed by NFT art and consistent tech development.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/bSArgzB0gCdDvlPd4YcWvFcE1qEVtyqMLPnhgVO_CZw")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<WNCX>>(0x2::coin::mint<WNCX>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WNCX>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

