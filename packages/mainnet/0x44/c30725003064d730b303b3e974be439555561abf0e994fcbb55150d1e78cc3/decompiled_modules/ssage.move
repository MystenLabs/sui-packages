module 0x44c30725003064d730b303b3e974be439555561abf0e994fcbb55150d1e78cc3::ssage {
    struct SSAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAGE>(arg0, 6, b"SSAGE", b"Suisage", b"Sausage - Suisage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sausage_Protector_048cf397a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

