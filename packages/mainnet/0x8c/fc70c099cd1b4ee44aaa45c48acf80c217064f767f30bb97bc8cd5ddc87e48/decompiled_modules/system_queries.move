module 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::system_queries {
    public fun get_address_by_handle(arg0: &0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::TippingSystem, arg1: vector<u8>) : 0x1::option::Option<address> {
        let (v0, v1) = 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::find_profile_address(arg0, arg1);
        if (v0) {
            0x1::option::some<address>(v1)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_tip(arg0: &0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::TippingSystem, arg1: u64) : 0x1::option::Option<0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::Tip> {
        let (v0, v1) = 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::get_tip(arg0, arg1);
        if (v0) {
            0x1::option::some<0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::Tip>(v1)
        } else {
            0x1::option::none<0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::Tip>()
        }
    }

    public fun history_size(arg0: &0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::TippingSystem) : u64 {
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::history_size(arg0)
    }

    public fun mist_to_sui(arg0: u64) : u64 {
        arg0 / 1000000000
    }

    public fun total_tips(arg0: &0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::TippingSystem) : u64 {
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::total_tips(arg0)
    }

    public fun total_volume(arg0: &0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::TippingSystem) : u64 {
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::total_volume(arg0)
    }

    // decompiled from Move bytecode v6
}

