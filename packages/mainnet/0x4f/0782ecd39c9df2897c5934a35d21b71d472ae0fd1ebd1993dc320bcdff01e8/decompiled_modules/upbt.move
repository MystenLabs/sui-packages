module 0x4f0782ecd39c9df2897c5934a35d21b71d472ae0fd1ebd1993dc320bcdff01e8::upbt {
    struct UPBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPBT>(arg0, 6, b"UPBT", b"UPPI BOT SUI", b"First Uppi Bot on Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uppi2_01_12fd7c7337.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

