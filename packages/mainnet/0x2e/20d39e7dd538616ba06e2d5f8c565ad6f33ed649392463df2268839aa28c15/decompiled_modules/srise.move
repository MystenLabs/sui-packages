module 0x2e20d39e7dd538616ba06e2d5f8c565ad6f33ed649392463df2268839aa28c15::srise {
    struct SRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRISE>(arg0, 6, b"SRISE", b"Suirise army", b"Community driven movement that believes in the rise of Sui network. We create, inspire, and lead the charge toward a future powered by Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043623_0d044c0daa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

