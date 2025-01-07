module 0x5d3bc2dfc1089d125fe24d0aad71dc113b7e07ce356e56a10d7d82ae7b9920e4::esui {
    struct ESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESUI>(arg0, 8, b"ESUI", b"EvilSui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTimkvjKJHXzA6eP2wZibrlwbdFncNCD7_cQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ESUI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

