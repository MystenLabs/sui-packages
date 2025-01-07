module 0xef45c0a20d9190f76c7ecdae4715d89f367c5be8736b4a17facaf5c680f12cc5::cornydog {
    struct CORNYDOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CORNYDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CORNYDOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CORNYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CORNYDOG>(arg0, 9, b"CORNYDOG", b"SUI CORNY DOG", b"SUI CORNY DOG MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfi70STebOSxsdPyVNdddEVvsuj8pwwhCg3U1IA6ozX7LIEDnIunM4J9XM3UvkAxBUVIE&usqp=CAU")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CORNYDOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORNYDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORNYDOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CORNYDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CORNYDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CORNYDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

