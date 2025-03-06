module 0x74b588c13bad28c03517bb8e038f2714b66830537818e11b125af2a9b80f339f::denquaid {
    struct DENQUAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENQUAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENQUAID>(arg0, 9, b"DENQUAID", b"Dennis Quaid", b"Born: April 9, 1954, Houston, TX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/DENQUAID.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DENQUAID>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENQUAID>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENQUAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

