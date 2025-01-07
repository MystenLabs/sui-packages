module 0x284d3b917550d149751d3d6b1dbbd855a50c1f5f93910222a184804b5101f07f::ai16z {
    struct AI16Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI16Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI16Z>(arg0, 6, b"AI16Z", b"ai16z on sui", b"ai16z is the first AI VC fund on sui, fully managed by Marc AIndreessen with recommendations from members of the DAO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a16z_546be0d429.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI16Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI16Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

