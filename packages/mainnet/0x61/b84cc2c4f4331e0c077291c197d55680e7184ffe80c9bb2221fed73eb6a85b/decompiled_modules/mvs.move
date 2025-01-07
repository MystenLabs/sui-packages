module 0x61b84cc2c4f4331e0c077291c197d55680e7184ffe80c9bb2221fed73eb6a85b::mvs {
    struct MVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVS>(arg0, 6, b"MVS", b"MOVEUS", b"Lets Fucking Move!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731826355917.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MVS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

