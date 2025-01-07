module 0x44688b0e4b09c459f89a5afd779fc02ad4c33a810de34f55adb8585591472aa6::smr {
    struct SMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMR>(arg0, 6, b"SMR", b"STRATEGI MEMES RESER", b"STRATEGIC MEMES RESERVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958280910.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

