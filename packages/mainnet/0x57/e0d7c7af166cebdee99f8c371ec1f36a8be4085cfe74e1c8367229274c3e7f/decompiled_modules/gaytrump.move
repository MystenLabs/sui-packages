module 0x57e0d7c7af166cebdee99f8c371ec1f36a8be4085cfe74e1c8367229274c3e7f::gaytrump {
    struct GAYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8jZtW89PjxqLwK7svrKK1GfwRmdrHqLjDWdMj1wrB3LY.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GAYTRUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"gayTRUMP")))), trim_right(b"OFFICIAL gayTRUMP               "), trim_right(x"496e74726f647563696e67204761795472756d7020546f6b656e3a20546865204d656d6520546f6b656e20546861742052657665616c7320746865205472757468210a0a5469726564206f66206265696e672064656365697665643f204761795472756d702072656d696e64732075732074686174206d616e792074686f756768742074686579207765726520696e76657374696e6720696e20737563636573732c2062757420696e207265616c6974792c206f6e6c79205472756d702062656e65666974732e0a4b65792046656174757265733a0a204177616b656e696e673a205265616c697a65207468617420796f75277665206265656e206d69736c6564210a20436f6d6d756e6974793a204a6f696e2061207465616d20746861742076616c7565732068756d6f7220616e6420637269746963616c207468696e6b69"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYTRUMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYTRUMP>>(v4);
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

