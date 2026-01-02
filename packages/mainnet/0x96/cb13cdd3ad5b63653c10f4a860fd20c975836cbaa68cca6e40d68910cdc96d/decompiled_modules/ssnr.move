module 0x96cb13cdd3ad5b63653c10f4a860fd20c975836cbaa68cca6e40d68910cdc96d::ssnr {
    struct SSNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSNR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/-aMWRnfACIfiaoQAK65L4Neb3DlaAxe4BFY73zKsrxI";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/-aMWRnfACIfiaoQAK65L4Neb3DlaAxe4BFY73zKsrxI"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<SSNR>(arg0, 9, trim_right(b"SSNR"), trim_right(b"SSNR  "), trim_right(b"SSNRGOTOFAN"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SSNR>>(0x2::coin::mint<SSNR>(&mut v5, 1000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSNR>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SSNR>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSNR>>(v4);
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

