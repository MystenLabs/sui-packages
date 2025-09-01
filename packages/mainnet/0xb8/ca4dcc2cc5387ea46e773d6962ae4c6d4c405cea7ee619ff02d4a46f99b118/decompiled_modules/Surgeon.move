module 0xb8ca4dcc2cc5387ea46e773d6962ae4c6d4c405cea7ee619ff02d4a46f99b118::Surgeon {
    struct SURGEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURGEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURGEON>(arg0, 9, b"SURG", b"Surgeon", b"trol surgeon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzwsYmPXQAAgPbh?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURGEON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURGEON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

