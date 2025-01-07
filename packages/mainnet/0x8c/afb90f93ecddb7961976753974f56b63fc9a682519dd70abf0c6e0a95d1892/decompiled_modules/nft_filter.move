module 0x79c477770f5035421d376a46706d41d3cbaa46712994ea81752d2fd04e3d6bed::nft_filter {
    struct Filter has copy, drop, store {
        type: 0x1::option::Option<u16>,
        sub_type: 0x1::option::Option<u16>,
    }

    public fun match(arg0: &Filter, arg1: &0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::BirdNFT) : bool {
        let (_, _, v2, v3, _, _) = 0xb23ee71e0f2d587fa5eea108f4f6c49c417f3c4b6a3fcfde8085e1c48558b34d::nft::info(arg1);
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

