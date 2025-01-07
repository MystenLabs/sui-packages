module 0x38018495dbcdd7b355cdf098d6f4a1019e14e959fc238cf1d18e890ac0c46ebf::FUCKU {
    struct PublicRedEnvelope has store, key {
        id: 0x2::object::UID,
        coins: 0x2::table_vec::TableVec<0x2::coin::Coin<FUCKU>>,
    }

    struct FUCKU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FUCKU>, arg1: 0x2::coin::Coin<FUCKU>) {
        0x2::coin::burn<FUCKU>(arg0, arg1);
    }

    public entry fun add_to_envelope(arg0: &mut PublicRedEnvelope, arg1: 0x2::coin::Coin<FUCKU>) {
        0x2::table_vec::push_back<0x2::coin::Coin<FUCKU>>(&mut arg0.coins, arg1);
    }

    fun init(arg0: FUCKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKU>(arg0, 2, b"FUCKU", b"FKU", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKU>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicRedEnvelope{
            id    : 0x2::object::new(arg1),
            coins : 0x2::table_vec::empty<0x2::coin::Coin<FUCKU>>(arg1),
        };
        0x2::transfer::share_object<PublicRedEnvelope>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUCKU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FUCKU>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint_multi(arg0: &mut 0x2::coin::TreasuryCap<FUCKU>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            0x2::coin::mint_and_transfer<FUCKU>(arg0, arg1, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    public entry fun take_from_envelope(arg0: &mut PublicRedEnvelope, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FUCKU>>(0x2::table_vec::pop_back<0x2::coin::Coin<FUCKU>>(&mut arg0.coins), 0x2::tx_context::sender(arg1));
    }

    public entry fun take_from_envelope_and_burn(arg0: &mut 0x2::coin::TreasuryCap<FUCKU>, arg1: &mut PublicRedEnvelope) {
        0x2::coin::burn<FUCKU>(arg0, 0x2::table_vec::pop_back<0x2::coin::Coin<FUCKU>>(&mut arg1.coins));
    }

    // decompiled from Move bytecode v6
}

