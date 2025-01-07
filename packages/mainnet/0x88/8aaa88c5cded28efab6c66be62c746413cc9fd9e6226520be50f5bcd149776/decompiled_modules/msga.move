module 0x888aaa88c5cded28efab6c66be62c746413cc9fd9e6226520be50f5bcd149776::msga {
    struct MSGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSGA>(arg0, 9, b"MSGA", b"Make Sui Grate Again", b"Make Sui Grate Again)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl5SO-iuHOLBRqwdUwhSJqso2lNVmiOyztpw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MSGA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

