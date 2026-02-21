module 0x3762fd9adaf0a5e56ef6e32ae8048e8bedc49b3d84f38793356e9b33b6ca052::futbol {
    struct FUTBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUTBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUTBOL>(arg0, 6, b"FUTBOL", b"feliz futbol", b"Disfruta viendo el partido", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1771660617319.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUTBOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUTBOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

