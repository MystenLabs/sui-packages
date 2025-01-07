module 0xfb633f3d0c850fa97f69f90521f7166d4279e29730878cbe7ec6823f7ebf2e59::beypa {
    struct BEYPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEYPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEYPA>(arg0, 6, b"BEYPA", b"BEYPAZARI", b"You've been scammed enough, grab a soda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731094608704.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEYPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEYPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

