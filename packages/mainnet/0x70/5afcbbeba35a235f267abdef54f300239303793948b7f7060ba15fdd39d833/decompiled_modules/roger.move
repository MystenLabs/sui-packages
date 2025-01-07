module 0x705afcbbeba35a235f267abdef54f300239303793948b7f7060ba15fdd39d833::roger {
    struct ROGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGER>(arg0, 6, b"ROGER", b"First Roger On Sui", b"First Roger On Sui: https://www.rogercoinsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d652n0_Qv_400x400_5efe89cc20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

