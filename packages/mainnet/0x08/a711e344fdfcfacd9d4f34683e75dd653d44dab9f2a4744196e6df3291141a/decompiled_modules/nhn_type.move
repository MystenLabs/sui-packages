module 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::nhn_type {
    struct NHN has drop {
        dummy_field: bool,
    }

    public fun nhn(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap) : NHN {
        NHN{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

