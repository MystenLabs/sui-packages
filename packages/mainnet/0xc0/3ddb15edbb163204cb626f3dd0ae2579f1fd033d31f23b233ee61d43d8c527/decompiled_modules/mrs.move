module 0xc03ddb15edbb163204cb626f3dd0ae2579f1fd033d31f23b233ee61d43d8c527::mrs {
    struct MRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRS>(arg0, 9, b"MRS", b"MisterySui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmarNAEQROPr9KPVWvaIMJdSrTEjSoJJeLkQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MRS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

