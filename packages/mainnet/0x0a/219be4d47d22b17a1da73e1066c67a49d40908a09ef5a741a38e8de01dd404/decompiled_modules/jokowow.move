module 0xa219be4d47d22b17a1da73e1066c67a49d40908a09ef5a741a38e8de01dd404::jokowow {
    struct JOKOWOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKOWOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKOWOW>(arg0, 9, b"JOKOWOW", b"Fufufafa", b"Fufufu fafa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/061b670f-90c8-4cb2-980d-f1b8c4dd77dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKOWOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKOWOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

