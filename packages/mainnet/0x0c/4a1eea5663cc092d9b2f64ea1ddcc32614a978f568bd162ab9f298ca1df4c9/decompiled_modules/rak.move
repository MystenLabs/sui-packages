module 0xc4a1eea5663cc092d9b2f64ea1ddcc32614a978f568bd162ab9f298ca1df4c9::rak {
    struct RAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAK>(arg0, 9, b"RAK", b"Rak", b"He's just a gator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/eT1JTNm.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAK>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

