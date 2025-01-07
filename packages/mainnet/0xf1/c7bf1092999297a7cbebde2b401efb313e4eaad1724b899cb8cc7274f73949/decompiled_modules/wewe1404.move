module 0xf1c7bf1092999297a7cbebde2b401efb313e4eaad1724b899cb8cc7274f73949::wewe1404 {
    struct WEWE1404 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE1404, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE1404>(arg0, 9, b"WEWE1404", b"WEWE", b"WEWE,WEWE1404", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a072137-aa97-4f42-9762-10a8bbdc564a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE1404>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE1404>>(v1);
    }

    // decompiled from Move bytecode v6
}

