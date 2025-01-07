module 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::bullshark {
    struct Bullshark has drop {
        dummy_field: bool,
    }

    public fun bullshark(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap) : Bullshark {
        Bullshark{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

