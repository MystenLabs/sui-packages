module 0x45a6cf335df16ae9e6c5d8eee0bc0138a3c8e6cbdb928c55c7dc21a4d152f510::usdd1 {
    struct USDD1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDD1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/Y_u8RCP6A1gqd8fJKkxG_64Bt6VhaSehzsGkKci3BSQ";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/Y_u8RCP6A1gqd8fJKkxG_64Bt6VhaSehzsGkKci3BSQ"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USDD1>(arg0, 9, trim_right(b"USDD1"), trim_right(b"USDD1  "), trim_right(b"USDD"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDD1>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USDD1>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDD1>>(v4);
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

