module 0x8029b611fd3e0ff96c05b831a2e56ecb1a2aba00bddff03e035f0cef45d1aeb7::network {
    struct NETWORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5cb280a0bb9bd8e9af5ae30c739b457b6a6064067f7d896c6677194be510283b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NETWORK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Network     ")))), trim_right(b"Network = Net Worth             "), trim_right(x"416e796f6e652077686f2773206d6164652069740a0a4469646e277420646f20697420616c6f6e650a0a426568696e64206576657279207261677320746f207269636865732073746f72790a0a49732061207465616d2071756965746c79206275696c64696e6720616e20656d706972650a0a596f7572204e6574776f726b20697320596f7572204e657420576f72746820202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NETWORK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NETWORK>>(v4);
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

