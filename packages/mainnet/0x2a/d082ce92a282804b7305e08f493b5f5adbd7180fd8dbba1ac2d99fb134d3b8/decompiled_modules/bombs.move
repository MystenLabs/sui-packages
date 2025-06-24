module 0x2ad082ce92a282804b7305e08f493b5f5adbd7180fd8dbba1ac2d99fb134d3b8::bombs {
    struct BOMBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMBS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/86fHD739Ng97TZnCE4UWiKHKupb4thVLW1e9Jecnpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOMBS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BOMBS       ")))), trim_right(b"Bombs Over Bagdad               "), trim_right(x"24424f4d4253206973206e6f742061626f75742077617220206974732061626f757420627265616b696e67206379636c65732c20666c697070696e6720746865207363726970742c20616e64206d616b696e67206e6f6973652077686572652073696c656e63652077617320666f726365642e20496e737069726564206279204f75746b617374732069636f6e696320747261636b2c20426f6d6273204f766572204261676461642073796d626f6c697a65732063726561746976652064697372757074696f6e2c207472757468206f7665722070726f706167616e64612c20616e642063756c74757265206465746f6e6174696e6720746865207374617475732071756f2e0a0a546869732069732061207369676e616c20666c61726520666f7220746865206d6973666974732c20617274697374732c20726562656c7320"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMBS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMBS>>(v4);
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

