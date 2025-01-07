module 0x55cf10c8c8b3394b28019a6942ae0e9e3e5e37ff6fcfaeb393ab72168b8ee706::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 9, b"FART", b"Fartcoin", b"FART ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d50f1bdead0f644b38f56bbc4d562f29blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

