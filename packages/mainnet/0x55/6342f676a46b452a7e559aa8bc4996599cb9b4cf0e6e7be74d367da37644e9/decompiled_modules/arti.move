module 0x556342f676a46b452a7e559aa8bc4996599cb9b4cf0e6e7be74d367da37644e9::arti {
    struct ARTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTI>(arg0, 9, b"ARTI", b"ARTICUNo", b"Articuno the best pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdJidrQ3AB5owIkDtQolOY0gI3-ikmwlh8eg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARTI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

