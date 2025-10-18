module 0xa028cf357a45c87a9cfc4e36a643b4ee13472b962c35910097c22d1fe39d3c97::usdugc {
    struct USDUGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDUGC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d84a39c521b5a2f55c35f89c54a4748e48eb0ec9506ff5e6e1e41378c21675c9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<USDUGC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"USDUGC      ")))), trim_right(b"Unstable Gold Coin              "), trim_right(x"4649525354202455534455474320474f4c4420544f4b454e204f4e20534f4c414e410a0a4d7920676f616c20697320746f206265636f6d652074686520636f6c646573742044455620696e207468652063727970746f207472656e6368657320616e64206d616b652072756e6e65727320746861742070656f706c652063616e2074727573742e0a0a492068617665203220636f696e732049206c61756e636865642066726f6d20736372617463682c207468697320616e64202450554d505452554d50206275742049276d206e6f74206e657720746f2063727970746f206f722072756e6e696e6720746f6b656e732e2e2e2e207365652062656c6f772e2e2e2e0a0a54686520686973746f7279206f6e206d652069732074686174204920616c736f206f776e207468652057573320434120595a59204b616e7965205765"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDUGC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDUGC>>(v4);
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

