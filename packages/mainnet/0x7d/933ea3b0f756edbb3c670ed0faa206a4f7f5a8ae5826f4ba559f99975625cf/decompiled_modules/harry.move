module 0x7d933ea3b0f756edbb3c670ed0faa206a4f7f5a8ae5826f4ba559f99975625cf::harry {
    struct HARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"54ee6053133cf817e1150f85353db8acde91cad26b2dfe4880591909b29fb1b6                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HARRY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HARRY       ")))), trim_right(b"Harry Slother                   "), trim_right(x"486172727920536c6f746865722020546865204368696c6c657374205370656c6c20696e2043727970746f200a486172727920536c6f746865722069736e74206a757374206120636f696e20206974732061206d6f76656d656e74206f662063616c6d2c2063616c63756c61746564206d6167696320696e2061206368616f746963206d61726b65742e20506f776572656420627920636f6d6d756e6974792c2067756964656420627920776973646f6d2028616e64206e617073292c20486172727920536c6f74686572206272696e677320746865207065726665637420626c656e64206f66206d656d652063756c7475726520616e6420576562332077697a61726472792e0a0a5768657468657220796f75277265206865726520666f72207468652076696265732c20746865207370656c6c732c206f72207468652073"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRY>>(v4);
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

