module 0x8b40fd481ad5465ebabdfca59013d24c9bab9f99309d4a9ddb77b13d93a5738e::lolcat {
    struct LOLCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4AcWvugzD1Jw4V6992CMt6DCezQ9tEhB8M4tWECHbonk.png?claimId=P2DRb6_i5AXysdPu                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LOLCAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LOLCAT      ")))), trim_right(b"Lolcat                          "), trim_right(x"6669727374206d656d6520696e2063727970746f21200a0a4c6f6c63617420697320666972737420706f73746564206d656d6520636174206f6e20426974636f696e74616c6b2066726f6d20323620446563656d62657220323031302e200a0a5573657220536861646f774f664861726272696e6765722073686172656420746869732063617420616e642064657363726962656420697420617320666f6c6c6f77733a2022686f7720636f756c6420616e79626f647920726566757365207468697320736f667420666c75666679206c6974746c65206c6f6c636174203f22202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLCAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLCAT>>(v4);
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

