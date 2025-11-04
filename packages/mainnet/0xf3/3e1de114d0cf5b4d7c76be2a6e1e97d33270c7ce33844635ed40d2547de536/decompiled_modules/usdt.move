module 0xf33e1de114d0cf5b4d7c76be2a6e1e97d33270c7ce33844635ed40d2547de536::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 85);
        0x1::vector::push_back<u8>(&mut v0, 83);
        0x1::vector::push_back<u8>(&mut v0, 68);
        0x1::vector::push_back<u8>(&mut v0, 84);
        let (v1, v2) = 0x2::coin::create_currency<USDT>(arg0, 6, v0, b"tafrt", b"Tokens for having fun among friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibdmzy6umk5drqgmaa7fti73thnxiy5c6hxcqqc4g72yfldv42weu")), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<USDT>(&mut v3, 66000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v3, @0xc24f4b3bd24c2435deb7e64a3a3a66bcde06835aca7df525c4a00b612eebc983);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v2);
    }

    // decompiled from Move bytecode v6
}

