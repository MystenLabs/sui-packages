module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch {
    public(friend) fun display_keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        v0
    }

    public(friend) fun owner_holders() : vector<address> {
        vector[@0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0, @0xee100c30fa1181ddb3736f40852ce8b517af0112b434d587d140b8e22d1c91f8, @0x22370ab0b39d67228ed5bd5910143143b5f03169ae464cd4f7695aba6c24c08]
    }

    public(friend) fun owner_orders() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"SM-OWNER-0001"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"SM-OWNER-0002"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"SM-OWNER-0003"));
        v0
    }

    public(friend) fun price_e12() : u128 {
        1000000000
    }

    public(friend) fun ref_value() : u64 {
        100000000
    }

    public(friend) fun seal_display() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Siaynoq Seal No. {serial}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(x"536961796e6f71205365616c206f6620546865205370696365204d656c616e67652e20486f6c64657273206d696e74205370696365204d656c616e67652c2067657420746865206461696c79207368617265206f66206465736b2074726164696e6720666565732c20616e64206f70656e207468652053746f7265686f7573652e20547261646561626c65206174207468652073656c6c6572e280997320707269636520616e642063757272656e63792e"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://junction-o2rv.onrender.com/nft/siaynoq-seal.png"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://thespicemelange.org/"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://thespicemelange.org/"));
        v0
    }

    public(friend) fun soos_coin() : 0x1::ascii::String {
        0x1::ascii::string(b"46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE")
    }

    public(friend) fun spice_display() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Spice Melange No. {serial}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(x"5370696365204d656c616e67652066726f6d20546865205370696365204d656c616e6765206465736b2e204d696e746564206279206120536961796e6f71205365616c20686f6c6465723b20747261646561626c65206f6e20746865206275696c742d696e20537569206465736b206174207468652073656c6c6572e280997320707269636520616e642063757272656e63792e"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://junction-o2rv.onrender.com/nft/spice-melange.png"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://thespicemelange.org/"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://thespicemelange.org/"));
        v0
    }

    public(friend) fun usdc_coin() : 0x1::ascii::String {
        0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC")
    }

    // decompiled from Move bytecode v7
}

