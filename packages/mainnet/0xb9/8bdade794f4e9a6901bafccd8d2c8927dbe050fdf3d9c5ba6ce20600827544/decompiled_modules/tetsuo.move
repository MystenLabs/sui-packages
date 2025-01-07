module 0xb98bdade794f4e9a6901bafccd8d2c8927dbe050fdf3d9c5ba6ce20600827544::tetsuo {
    struct TETSUO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TETSUO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TETSUO>>(0x2::coin::mint<TETSUO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TETSUO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8i51XNNpGaKaj4G4nDdmQh95v4FKAxw8mhtaRoKd9tE8.png?size=lg&key=e6100f                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TETSUO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TETSUO  ")))), trim_right(b"Tetsuo Coin                     "), trim_right(b"Tetsuo Coin ($TETSUO)  Wen moon? NOW with Tetsuo Coin!  Created by some guy named Tetsuo who writes crazy low-level code, this coin is built different. While your normie coins are writing fancy whitepapers, we're out here optimizing assembly code for maximum speed (or whatever that means). Why TETSUO                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETSUO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TETSUO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TETSUO>>(0x2::coin::mint<TETSUO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

