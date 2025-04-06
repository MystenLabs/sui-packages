module 0xc1a9cfce5aa678368a938bbc16c70bccb70b2dbcd9e73c051e2328120bc83f9::swrsu {
    struct SWRSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWRSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWRSU>(arg0, 9, b"SWRSU", b"swordsui", x"5355c4b02053574f524453205350414345204f52204d4f4f4e2020545241c4b04e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4d1451c7cb54139504c3eeeb354d3655blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWRSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWRSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

