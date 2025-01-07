module 0xd57d5262d059dbf7d1aac97542cad405714383d8edad6ca3b7d0c0fa90afb44c::pnutbird {
    struct PNUTBIRD has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTBIRD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PNUTBIRD>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PNUTBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PNUTBIRD>(arg0, 9, b"PnutBird", b"Sui Pnut Bird", b"PnutBird Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w7.pngwing.com/pngs/545/1016/png-transparent-peanut-peggy-jean-bird-fruit-groundnut-animals-peanut-cartoon.png")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PNUTBIRD>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTBIRD>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTBIRD>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PNUTBIRD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTBIRD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PNUTBIRD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

