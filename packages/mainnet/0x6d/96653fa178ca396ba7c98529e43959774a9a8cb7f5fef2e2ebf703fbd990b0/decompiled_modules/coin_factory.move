module 0x6d96653fa178ca396ba7c98529e43959774a9a8cb7f5fef2e2ebf703fbd990b0::coin_factory {
    struct BlockusCoinMintEvent has copy, drop {
        minted_by: address,
        amount: u64,
        recipient: address,
    }

    struct BlockusCoinBurnEvent has copy, drop {
        burned_by: address,
        amount: u64,
    }

    struct COIN_FACTORY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<COIN_FACTORY>, arg1: 0x2::coin::Coin<COIN_FACTORY>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockusCoinBurnEvent{
            burned_by : 0x2::tx_context::sender(arg2),
            amount    : 0x2::coin::value<COIN_FACTORY>(&arg1),
        };
        0x2::event::emit<BlockusCoinBurnEvent>(v0);
        0x2::coin::burn<COIN_FACTORY>(arg0, arg1);
    }

    fun init(arg0: COIN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_FACTORY>(arg0, 0, b"SHARD", b"Ambrus", b"Ambrus studio games weapon shards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://firebasestorage.googleapis.com/v0/b/blockus-prod.appspot.com/o/collections%2FYlxE8kcFVdPZpeb7gcxNmbtTQHGY%2FWeapon%20Shard1709869256025.png?alt=media&token=cd56eb58-28a1-44be-b319-e12ba350e5a3")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_FACTORY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_FACTORY>>(v0, @0xb59e0afe3047f32c63db92f0b126242006c2a41d43e44edc680d6bcd05d3f06f);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_FACTORY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        let v0 = BlockusCoinMintEvent{
            minted_by : 0x2::tx_context::sender(arg3),
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<BlockusCoinMintEvent>(v0);
        0x2::coin::mint_and_transfer<COIN_FACTORY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

