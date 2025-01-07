module 0x1e0b162a0739300f1fe98bcdc7d677bc293a56be93e784425d15605d6f7f4b18::toki {
    struct TOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKI>(arg0, 6, b"TOKI", b"TokiTheHippodog", b"Toki the hippo dog is a cross a between a sharpei And cocker spanil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_061554_cf05351615.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

