module 0x599abffc9117e57ef78800e6b34c88c06b73460a5f7ebfc65e8fa3299c5e8069::psps {
    struct PSPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSPS>(arg0, 6, b"PSPS", b"Boba Cat", x"2450535053206973206120746f6b656e20696e737069726564206279207468652061646f7074656420636174206f6620446f6765636f696e20436f2d666f756e646572200a4042696c6c794d326b202c72616973696e672061776172656e657373206f662063727970746f207068696c616e7468726f707920616e6420737570706f7274696e6720706574207368656c7465727320776f726c64776964652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971984404.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

