module 0x3885ab2eb6ebad04253490433b6587d81c4aff6ff56a87c84f7165f0f954ac28::miharu {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHARU>(arg0, 6, b"MIHARU", b"Miharu", x"4120646f6c7068696e2077697468206120636861726d696e6720736d696c652c686973206e616d65206973204d69686172752068747470733a2f2f7777772e6461696c79646f742e636f6d2f6d656d65732f736d696c696e672d646f6c7068696e2d6d656d652f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_09_50_46_d235aca507.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

