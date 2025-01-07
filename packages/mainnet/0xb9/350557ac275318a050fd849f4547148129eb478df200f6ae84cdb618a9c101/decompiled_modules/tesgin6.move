module 0xb9350557ac275318a050fd849f4547148129eb478df200f6ae84cdb618a9c101::tesgin6 {
    struct TESGIN6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESGIN6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESGIN6>(arg0, 6, b"Tesgin6", b"Tesgin65", b"Tesgt1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732584326947.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESGIN6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESGIN6>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

