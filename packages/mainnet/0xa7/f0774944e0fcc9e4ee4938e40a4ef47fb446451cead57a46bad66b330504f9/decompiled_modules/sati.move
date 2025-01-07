module 0xa7f0774944e0fcc9e4ee4938e40a4ef47fb446451cead57a46bad66b330504f9::sati {
    struct SATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATI>(arg0, 9, b"SATI", b"Aras", b"IRAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87592df2-f61f-43e6-9108-1b1de114d175.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

