module 0x490bccd0d3fa2b4d45eade852687cf17273091aa3d131ad23d838042034d893e::trojin {
    struct TROJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROJIN>(arg0, 9, b"TROJIN", b"Trojan", b"Best trojan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/786aa884-1cc8-44b4-8389-2eb89d71d3c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROJIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

