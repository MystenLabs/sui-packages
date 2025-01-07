module 0x55a02c068ba590261b7dbbd1870300b14dfd69d07bc6f6721020727faac3f828::suicr7 {
    struct SUICR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICR7>(arg0, 6, b"SUICR7", b"SUIII CR7", b"SUIII CR7 is a meme coin inspired by the legendary footballer Cristiano Ronaldo and his iconic \"SUIII\" celebration. Built on the SUI Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734127822976.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICR7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICR7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

