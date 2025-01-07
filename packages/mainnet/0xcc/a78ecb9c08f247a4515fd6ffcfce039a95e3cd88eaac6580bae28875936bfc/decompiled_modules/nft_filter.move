module 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::nft_filter {
    struct Filter has copy, drop, store {
        type: 0x1::option::Option<u16>,
        sub_type: 0x1::option::Option<u16>,
    }

    public fun match(arg0: &Filter, arg1: &0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFT) : bool {
        let (_, _, v2, v3, _, _) = 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::info(arg1);
        if (0x1::option::is_some<u16>(&arg0.type) && *0x1::option::borrow<u16>(&arg0.type) != v2) {
            return false
        };
        if (0x1::option::is_some<u16>(&arg0.sub_type) && *0x1::option::borrow<u16>(&arg0.sub_type) != v3) {
            return false
        };
        true
    }

    public fun new(arg0: 0x1::option::Option<u16>, arg1: 0x1::option::Option<u16>) : Filter {
        Filter{
            type     : arg0,
            sub_type : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

