module 0xa235577c053d8ae26fef48e004f0dc5a4449c2550ea06444507186e0732082f7::diamkau {
    struct DIAMKAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMKAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMKAU>(arg0, 9, b"DIAMKAU", b"Tolongkaki", b"Stupid meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/883b9dfa-0a5e-4560-9b5b-9c37f13df0e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMKAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMKAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

