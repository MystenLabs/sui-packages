module 0xfd0d10a05b9e4651c647adab3596fe0075b3ce26a7fe3b97c302a604da3a646a::tup {
    struct TupTokenMintedEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct TupTokenBurnedEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct TUP has drop {
        dummy_field: bool,
    }

    struct TupAdmin has store, key {
        id: 0x2::object::UID,
        tokens_minted: u64,
        tokens_burned: u64,
    }

    fun borrow_tup_treasury_mut(arg0: &mut TupAdmin) : &mut 0x2::coin::TreasuryCap<TUP> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<TUP>>(&mut arg0.id, 0x1::type_name::get<TUP>())
    }

    public fun burn_token(arg0: &mut TupAdmin, arg1: 0x2::coin::Coin<TUP>) {
        0x2::coin::burn<TUP>(borrow_tup_treasury_mut(arg0), arg1);
        let v0 = TupTokenBurnedEvent<TUP>{amount: 0x2::coin::value<TUP>(&arg1)};
        0x2::event::emit<TupTokenBurnedEvent<TUP>>(v0);
    }

    fun init(arg0: TUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUP>(arg0, 6, b"TUP", b"TUP", b"TUP Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/meme/images/d/dc/Shotweb.jpg")), arg1);
        let v2 = v0;
        let v3 = 100000000000000;
        let v4 = TupTokenMintedEvent<TUP>{amount: v3};
        0x2::event::emit<TupTokenMintedEvent<TUP>>(v4);
        let v5 = TupAdmin{
            id            : 0x2::object::new(arg1),
            tokens_minted : 0,
            tokens_burned : 0,
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<TUP>>(&mut v5.id, 0x1::type_name::get<TUP>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TUP>>(0x2::coin::mint<TUP>(&mut v2, v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<TupAdmin>(v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

