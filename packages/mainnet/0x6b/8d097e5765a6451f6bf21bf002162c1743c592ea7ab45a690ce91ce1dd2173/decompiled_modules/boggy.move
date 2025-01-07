module 0x6b8d097e5765a6451f6bf21bf002162c1743c592ea7ab45a690ce91ce1dd2173::boggy {
    struct BOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGGY>(arg0, 6, b"BOGGY", b"Boggy On Sui", b"He IS THE GOODEST BOY OUT THERE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_RD_Kd_En6_400x400_1_37776c407f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

