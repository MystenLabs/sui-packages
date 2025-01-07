module 0xf823f16b6b0738749f044edbcb5270b750c9b96459e2346485d01268fe5e6012::dimen {
    struct DIMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIMEN>(arg0, 6, b"DIMEN", b"Dimden AI", b"The best Dimden AI to the moooooooooooon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dimden_56074660a1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

