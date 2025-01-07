module 0xf1e5e98ef271406732df04324e50f549e22c7d66390c9ded6030ca96653e0e4::pepechad {
    struct PEPECHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECHAD>(arg0, 6, b"PEPECHAD", b"PEPE THE CHAD", x"50657065207468652043686164206973206261636b21204d6f726520706f77657266756c20616e642070756d7065642075702c20726561647920746f20646f6d696e617465207468652063727970746f207363656e652e2054686520756c74696d61746520616c706861206d656d652065766f6c7574696f6e20686173206c616e646564207072657061726520666f722074686520666c65782120234348414454414b454f5645520a0a574520415245204c4f4f4b494e4720464f52205245414c204348414453204f4e4c592c20544f204255494c4420464f554e444154494f4e2c204a454554532053544159204157415921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_289c334bb6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

