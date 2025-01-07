module 0x39d8a8d134821d59a717b3621cdae9fa1797af25190a14c6e37947cfd8f23bf8::bullb {
    struct BULLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLB>(arg0, 6, b"Bullb", b"BUBL", b"Bubbling on @SuiNetwork to make frens! BUBBLE IT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731334518386.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

