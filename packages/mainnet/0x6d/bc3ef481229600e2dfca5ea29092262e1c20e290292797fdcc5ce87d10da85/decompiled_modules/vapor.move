module 0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::vapor {
    struct VAPOR has drop {
        dummy_field: bool,
    }

    struct VAPOR_ADMIN has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<VAPOR>,
        invalid_mint_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public entry fun burn(arg0: &mut Treasury, arg1: 0x2::coin::Coin<VAPOR>) {
        0x2::balance::decrease_supply<VAPOR>(&mut arg0.supply, 0x2::coin::into_balance<VAPOR>(arg1));
    }

    public fun create_mint_cap(arg0: &0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::OwnerCap<VAPOR_ADMIN>, arg1: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{id: 0x2::object::new(arg1)}
    }

    public fun destroy_mint_cap(arg0: MintCap) {
        let MintCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_invalid_mint_cap(arg0: &Treasury, arg1: u64) : 0x2::object::ID {
        *0x1::vector::borrow<0x2::object::ID>(0x2::vec_set::keys<0x2::object::ID>(&arg0.invalid_mint_caps), arg1)
    }

    public fun get_total_supply(arg0: &Treasury) : u64 {
        0x2::balance::supply_value<VAPOR>(&arg0.supply)
    }

    fun init(arg0: VAPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VAPOR_ADMIN{dummy_field: false};
        0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::transfer_owner_cap<VAPOR_ADMIN>(0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::create_owner_cap<VAPOR_ADMIN>(v0, arg1), 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<VAPOR>(arg0, 6, b"VAPOR", b"Vapor DAO", b"A treasury backed coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeibdttsqfi355hzrc4jecsn2pk2yip7kdxie52c7zf72eiq3pucvqq.ipfs.nftstorage.link/")), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<VAPOR>(&mut v3, 50000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAPOR>>(v2);
        let v4 = Treasury{
            id                : 0x2::object::new(arg1),
            supply            : 0x2::coin::treasury_into_supply<VAPOR>(v3),
            invalid_mint_caps : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Treasury>(v4);
    }

    public entry fun invalidate_mint_cap(arg0: &0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::OwnerCap<VAPOR_ADMIN>, arg1: &mut Treasury, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.invalid_mint_caps, arg2);
    }

    public fun mint(arg0: &MintCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAPOR> {
        let v0 = 0x2::object::id<MintCap>(arg0);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg1.invalid_mint_caps, &v0), 0);
        0x2::coin::from_balance<VAPOR>(0x2::balance::increase_supply<VAPOR>(&mut arg1.supply, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

