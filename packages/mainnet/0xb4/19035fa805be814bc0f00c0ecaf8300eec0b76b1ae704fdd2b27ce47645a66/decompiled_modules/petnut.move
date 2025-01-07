module 0xb419035fa805be814bc0f00c0ecaf8300eec0b76b1ae704fdd2b27ce47645a66::petnut {
    struct PETNUT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PETNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PETNUT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PETNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PETNUT>(arg0, 9, b"PETNUT", b"SUI PETNUT", b"SUI PETNUT MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/1379207489/vector/cute-yellow-hamster-stands-and-chews-a-nut-on-a-white-background.jpg?s=612x612&w=0&k=20&c=AOVbbgQUO4pf9M1B6n3ZXaik3NZQXbiwSFOSX-_46SU=")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PETNUT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETNUT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETNUT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PETNUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PETNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PETNUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

