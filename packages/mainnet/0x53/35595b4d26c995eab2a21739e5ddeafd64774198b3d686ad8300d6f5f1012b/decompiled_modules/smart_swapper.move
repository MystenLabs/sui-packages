module 0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::smart_swapper {
    struct ETH {
        dummy_field: bool,
    }

    struct BTC {
        dummy_field: bool,
    }

    struct KTS {
        dummy_field: bool,
    }

    entry fun cross_pool_swap(arg0: &mut 0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::dev_pass::Subscription<0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::some_amm::DEVPASS>) {
        0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::some_amm::dev_swap<ETH, BTC>(0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::dev_pass::use_pass<0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::some_amm::DEVPASS>(arg0));
        0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::some_amm::dev_swap<BTC, KTS>(0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::dev_pass::use_pass<0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::some_amm::DEVPASS>(arg0));
    }

    // decompiled from Move bytecode v6
}

