module 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::nft_filter {
    struct Filter has copy, drop, store {
        attrs: vector<0x1::option::Option<u16>>,
    }

    public fun match(arg0: &Filter, arg1: &0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::BirdNFT) : bool {
        let (_, _, v2, v3, _, _) = 0xece89bccb0a14a3235616deb1172e0e95689afccadd2608a5561a3e173bb70a7::nft::info(arg1);
        if (0x1::option::is_some<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 0)) && *0x1::option::borrow<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 0)) != v2) {
            return false
        };
        if (0x1::option::is_some<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 1)) && *0x1::option::borrow<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 1)) != v3) {
            return false
        };
        true
    }

    public fun new(arg0: vector<0x1::option::Option<u16>>) : Filter {
        Filter{attrs: arg0}
    }

    public fun new2(arg0: 0x1::option::Option<u16>, arg1: 0x1::option::Option<u16>) : Filter {
        let v0 = 0x1::vector::empty<0x1::option::Option<u16>>();
        0x1::vector::push_back<0x1::option::Option<u16>>(&mut v0, arg0);
        0x1::vector::push_back<0x1::option::Option<u16>>(&mut v0, arg1);
        Filter{attrs: v0}
    }

    // decompiled from Move bytecode v6
}

