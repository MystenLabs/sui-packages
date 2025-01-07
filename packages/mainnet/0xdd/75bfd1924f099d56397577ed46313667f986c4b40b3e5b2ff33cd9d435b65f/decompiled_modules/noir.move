module 0xdd75bfd1924f099d56397577ed46313667f986c4b40b3e5b2ff33cd9d435b65f::noir {
    struct NOIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOIR>(arg0, 6, b"NOIR", b"Noir", b"The savage monkey of Crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732486560622.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

