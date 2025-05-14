module 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::nft_filter {
    struct Filter has copy, drop, store {
        attrs: vector<0x1::option::Option<u16>>,
    }

    public fun match(arg0: &Filter, arg1: &0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFT) : bool {
        let (_, _, v2, v3, _, _) = 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::info(arg1);
        if (0x1::option::is_some<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 0)) && *0x1::option::borrow<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 0)) != v2) {
            return false
        };
        if (0x1::option::is_some<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 1)) && *0x1::option::borrow<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 1)) != v3) {
            return false
        };
        true
    }

    public fun matchV2(arg0: &Filter, arg1: &0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT) : bool {
        let (_, v1, v2, _) = 0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::info(arg1);
        if (0x1::option::is_some<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 0)) && *0x1::option::borrow<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 0)) != v1) {
            return false
        };
        if (0x1::option::is_some<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 1)) && *0x1::option::borrow<u16>(0x1::vector::borrow<0x1::option::Option<u16>>(&arg0.attrs, 1)) != (v2 as u16)) {
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

