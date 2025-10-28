module 0x7ef5df02324c5162443033639eb584eb1f3b8303289999e13dacf413ce91543d::itbc {
    struct ITBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITBC>(arg0, 9, b"ITBC", b"THIROMA COIN", b"Follow the story of Thiroma as he explores the greatest mysteries of the universe and seeks to return to the planet he once called home with the help of the friends .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfVJZxnhQGX3boXGdjMBqv385R45ArJPw4PyXG6wBJQXt")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ITBC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITBC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

