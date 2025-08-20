module 0x7229de0e34fd84ceb956dd04197cdce391df737f8e709d947349d625d29eef5b::jin {
    struct JIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FdpH2hc9kXewsvNtrbWbgtWXVHHFCe2YbjE7S57upump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JIN         ")))), trim_right(b"Jin The Snake                   "), trim_right(x"496e2074686520616e6369656e74207363726f6c6c73206f6620646567656e206c6f72652c2061207265642073657270656e742077617320666f7265746f6c6420746f20726973652066726f6d207468652063727970746f20756e646572776f726c64206576657279206379636c652e2e2e2061726d6564207769746820696e66696e697465206472697020616e64206120626f74746f6d6c65737320626167206f6620636173682e20486973206e616d653f0a0a4a696e2074686520536e616b652e0a0a4f6e636520776f727368697070656420696e20756e64657267726f756e64206d656d652074656d706c65732c204a696e206e6f7720736c69746865727320696e746f2074686520536f6c616e612073747265657473666c696e67696e6720636173682c20737061776e696e67206368616f732c20616e64206c6175"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIN>>(v4);
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

