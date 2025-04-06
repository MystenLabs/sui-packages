module 0x3b61611ae48ddfd73a9ea5594239243d9080d0e2992a90ca434059e00ae6684a::doged {
    struct DOGED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGED>(arg0, 9, b"DogeD", b"dogehasbigD", b"doge has 8 inch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/30fd070819f9e8b5255d1405eeb2fbdfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

