module 0x25b934a345371f38308428a7416db693ae56808677e9e73a58b17710c3e682ee::nft_filter {
    struct Filter has copy, drop, store {
        attrs: vector<0x1::option::Option<u16>>,
    }

    public fun match(arg0: &Filter, arg1: &0x3004a1c316760c6dec255ed49c5e551390e542f626d09cfbcf2d9305baf7351e::nft::BirdNFT) : bool {
        let (_, _, v2, v3, _, _) = 0x3004a1c316760c6dec255ed49c5e551390e542f626d09cfbcf2d9305baf7351e::nft::info(arg1);
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

