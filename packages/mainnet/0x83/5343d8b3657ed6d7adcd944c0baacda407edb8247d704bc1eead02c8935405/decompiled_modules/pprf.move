module 0x835343d8b3657ed6d7adcd944c0baacda407edb8247d704bc1eead02c8935405::pprf {
    struct PPRF has drop {
        dummy_field: bool,
    }

    struct MetadataLock has store, key {
        id: 0x2::object::UID,
        metadata_cap: 0x2::coin_registry::MetadataCap<PPRF>,
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: PPRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PPRF>(arg0, 9, 0x1::string::utf8(b"PPRF"), 0x1::string::utf8(b"PPRF Token"), 0x1::string::utf8(b"PaperProof Protocol Token (PPRF) is the governance and treasury token of PaperProof, a decentralized protocol on Sui for publishing, verifying, distributing, and engaging with digital artifacts. PPRF supports protocol governance, treasury stewardship, ecosystem growth, and long-term sustainability. PaperProof combines on-chain records with decentralized storage to enable verifiable content and global community participation around published artifacts."), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/46egR1yyhHVRNdNx72ICBQ99AiywUaMwfi00CDYznUI"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<PPRF>(&mut v3, v2);
        let v4 = MetadataLock{
            id           : 0x2::object::new(arg1),
            metadata_cap : 0x2::coin_registry::finalize<PPRF>(v3, arg1),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<PPRF>>(0x2::coin::mint<PPRF>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<MetadataLock>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun total_supply_base_units() : u64 {
        10000000000000000000
    }

    public fun total_supply_tokens() : u64 {
        10000000000
    }

    public fun update_icon_url(arg0: &MetadataLock, arg1: &mut 0x2::coin_registry::Currency<PPRF>, arg2: vector<u8>) {
        0x2::coin_registry::set_icon_url<PPRF>(arg1, &arg0.metadata_cap, 0x1::string::utf8(arg2));
    }

    // decompiled from Move bytecode v7
}

