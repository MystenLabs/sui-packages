module 0x2b2182a0537310ed7e6afca53c1ac091fc0b707787105ae65fcaf2d471de3b94::ttt {
    struct TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 9, b"TTT", b"Testtest", b"efefwfef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p166593_p_v10_as.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

