module 0xfcb476869a01c72c3f8db1d3403c5041ed5455a4f1ccea0cf11010f9f64cdc4d::earn {
    struct EARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARN>(arg0, 9, b"EARN", b"Earning", b"Earn n earn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8df5e6c4aa5c5970f12a9be86698626dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

