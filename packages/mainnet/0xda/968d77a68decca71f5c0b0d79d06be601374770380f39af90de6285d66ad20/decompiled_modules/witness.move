module 0x61d53088c7beede5b7f087ed950563b94722104f26f5f84ea5d51921b1b7bf4::witness {
    struct WaterXStaking has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : WaterXStaking {
        WaterXStaking{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

