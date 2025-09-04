module 0xfcc750aeefe9253bd04275618d195bae8c477fe7ea81c49b88c13fdb6f9e8b63::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/SK2d4yAVFcGqSGi6CmFGOr-Emdbgjb96KHEHi7EtEng";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/SK2d4yAVFcGqSGi6CmFGOr-Emdbgjb96KHEHi7EtEng"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<DOGE>(arg0, 9, trim_right(b"DOGE"), trim_right(b"Dogecoin"), trim_right(b"Dogecoin is a peer-to-peer cryptocurrency based on Shiba Inu meme that quickly became popular on social media."), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGE>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v4);
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

