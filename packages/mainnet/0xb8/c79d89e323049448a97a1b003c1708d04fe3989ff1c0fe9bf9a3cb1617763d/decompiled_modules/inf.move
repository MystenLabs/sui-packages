module 0xb8c79d89e323049448a97a1b003c1708d04fe3989ff1c0fe9bf9a3cb1617763d::inf {
    struct INF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<INF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<INF>>(0x2::coin::mint<INF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: INF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x00f116ac0c304c570daaa68fa6c30a86a04b5c5f.png?size=lg&key=c38796                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<INF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"INF     ")))), trim_right(b"INFERNO                         "), trim_right(x"596565686177202d207468697320626c617a696e672062756c6c2069732073657474696e6720746865204d454d4546492070726169726965206f6e20666972652120546869732061696e277420796f7572206176657261676520746f6b656e20206974277320612066756c6c2d6f6e20726f64656f206f66206275726e696e6720686f7420746f6b656e6f6d69637320616e642077696c642077657374206578636974656d656e74206275696c7420746f20737570706f72742044617920323830206f6620546974616e5820616e64206272696e672076616c756520746f20616c6c206f6620494e4645524e4f204b494e47444f4d20616e64206265796f6e6420212100202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INF>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<INF>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<INF>>(0x2::coin::mint<INF>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

