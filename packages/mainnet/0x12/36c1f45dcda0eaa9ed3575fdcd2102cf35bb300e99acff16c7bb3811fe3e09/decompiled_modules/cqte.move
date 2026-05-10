module 0x1236c1f45dcda0eaa9ed3575fdcd2102cf35bb300e99acff16c7bb3811fe3e09::cqte {
    struct CQTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CQTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/rZlFORlZNzZAFdtYukMW3KxoMQfV7SWYajBX82R_3W4";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/rZlFORlZNzZAFdtYukMW3KxoMQfV7SWYajBX82R_3W4"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<CQTE>(arg0, 9, trim_right(b"CQTE"), trim_right(b"CQTE  "), trim_right(b"gotofan"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CQTE>>(0x2::coin::mint<CQTE>(&mut v5, 1000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CQTE>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CQTE>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CQTE>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

