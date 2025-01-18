module 0xf102e55aa49a553c2fbad3d131a89990775cfaa73e7e749ad47ac3c491920a3::blues {
    struct BLUES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUES>(arg0, 9, b"BLUES", b"BlueShark", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBM0UezTtG6MDpcth0b0p6PtQQJliuBoptow&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUES>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

