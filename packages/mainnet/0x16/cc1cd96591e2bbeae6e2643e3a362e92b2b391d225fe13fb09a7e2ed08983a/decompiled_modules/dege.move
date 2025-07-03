module 0x16cc1cd96591e2bbeae6e2643e3a362e92b2b391d225fe13fb09a7e2ed08983a::dege {
    struct DEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGE>(arg0, 8, b"Dege", b"DegeCoin", x"2444454745202d20426f726e20746f206d656d652e204f6666696369616c6c7920456e646f7273696e67200a40576f726c644c6962657274796669", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/9347251b-7bb3-44d0-8178-8c59fac52cc5.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEGE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

