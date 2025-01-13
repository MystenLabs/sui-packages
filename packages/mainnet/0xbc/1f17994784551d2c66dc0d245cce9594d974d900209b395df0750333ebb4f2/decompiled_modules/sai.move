module 0xbc1f17994784551d2c66dc0d245cce9594d974d900209b395df0750333ebb4f2::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SAI>, arg1: 0x2::coin::Coin<SAI>) {
        0x2::coin::burn<SAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x2b3989bd9544e6221fe3696c4bd063bba2b50268.png?size=lg&key=9de7d9                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SAI       ")))), trim_right(b"SKRYPT AI                       "), trim_right(x"534b52595054202824534149290a536b7279707420697320616e20616476616e63656420414920746578742067656e657261746f722074686174207265766f6c7574696f6e697a657320636f6e74656e74206372656174696f6e2e2046726f6d20636f6d70656c6c696e672061727469636c657320746f2063726561746976652073746f7269657320616e64206d61726b6574696e67206d6174657269616c732c20536b727970742064656c697665727320686967682d7175616c6974792c2068756d616e2d6c696b652074657874207461696c6f72656420746f20796f7572206e65656473202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAI>>(v5);
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

