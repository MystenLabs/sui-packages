module 0x4e0668821d1663a3065ded43bb0ce017eb3d133db49453dd70824cad04b55a24::move {
    struct MOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE>(arg0, 9, b"MOVE", b"We love move", b"Move >>>> Solidity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/SvaCqLc.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOVE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

