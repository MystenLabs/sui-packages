module 0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd {
    struct BKUSD has drop {
        dummy_field: bool,
    }

    struct Minter has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BKUSD>,
    }

    public(friend) fun burn(arg0: &mut Minter, arg1: 0x2::coin::Coin<BKUSD>) {
        0x2::coin::value<BKUSD>(&arg1);
        0x2::coin::burn<BKUSD>(&mut arg0.cap, arg1);
    }

    public fun get_total_supply(arg0: &Minter) : u64 {
        0x2::coin::total_supply<BKUSD>(&arg0.cap)
    }

    fun init(arg0: BKUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKUSD>(arg0, 6, b"BKUSD", b"Basket-backed USD", b"BKUSD is a multi-stablecoin-backed digital asset on Sui, minted 1:1 against supported stablecoins and redeemable for a proportional share of its transparent on-chain reserves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiblrxh3smfrmmigieokob4ukrg65veiziwj6rg6ycsfqb6sjjxg6a")), arg1);
        let v2 = v1;
        0x2::object::id<0x2::coin::CoinMetadata<BKUSD>>(&v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKUSD>>(v2);
        let v3 = Minter{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<Minter>(v3);
    }

    public(friend) fun mint(arg0: &mut Minter, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BKUSD>(&mut arg0.cap, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v7
}

