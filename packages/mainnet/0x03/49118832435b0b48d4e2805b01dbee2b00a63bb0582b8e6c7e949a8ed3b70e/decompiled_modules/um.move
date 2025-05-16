module 0x349118832435b0b48d4e2805b01dbee2b00a63bb0582b8e6c7e949a8ed3b70e::um {
    struct UM has drop {
        dummy_field: bool,
    }

    fun init(arg0: UM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UM>(arg0, 9, b"UM", b"uralmary", b"its neve foreve. Living for me.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4f802dbffa0a4a8fabc9bd8c6e68e9e9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

