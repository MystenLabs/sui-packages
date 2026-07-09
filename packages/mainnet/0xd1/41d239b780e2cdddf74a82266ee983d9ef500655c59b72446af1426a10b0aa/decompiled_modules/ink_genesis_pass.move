module 0xd141d239b780e2cdddf74a82266ee983d9ef500655c59b72446af1426a10b0aa::ink_genesis_pass {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        minted: u64,
        max_supply: u64,
        treasury: address,
    }

    struct PaymentAccepted has copy, drop {
        payer: address,
        mint_number: u64,
        monad_address_hash: vector<u8>,
        paid_at: u64,
    }

    struct TreasuryUpdated has copy, drop {
        treasury: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Collection{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Ink Genesis Pass"),
            description : 0x1::string::utf8(b"Sui payment receipt for an Ink Genesis Pass NFT minted on Monad through Ink + Ika."),
            image_url   : 0x1::string::utf8(b"ipfs://bafkreihqp7t3lq7d3hifchcfanwqm5ezjrrfexf5yom6cy66jg422naqfm"),
            minted      : 0,
            max_supply  : 250,
            treasury    : @0x5b2a9dd20f1b50ab289ed134aeb6d78fa24687b5dd0512bd914c059d3fe116e,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Collection>(v1);
    }

    public fun max_supply(arg0: &Collection) : u64 {
        arg0.max_supply
    }

    public entry fun mint(arg0: &mut Collection, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < arg0.max_supply, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 1500000000, 1);
        let v0 = arg0.minted + 1;
        arg0.minted = v0;
        let v1 = PaymentAccepted{
            payer              : 0x2::tx_context::sender(arg5),
            mint_number        : v0,
            monad_address_hash : arg3,
            paid_at            : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PaymentAccepted>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.treasury);
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut Collection, arg2: address) {
        assert!(arg2 != @0x0, 2);
        arg1.treasury = arg2;
        let v0 = TreasuryUpdated{treasury: arg2};
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun treasury(arg0: &Collection) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

