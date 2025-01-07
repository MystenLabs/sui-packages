module 0x1661c9ef4324c8bd99aac4e0d80c73bf2b703d0e2c09db3a40196f4603b2e931::lucian {
    struct LUCIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCIAN>(arg0, 9, b"LUCIAN", b"Lucia", b"Lolvn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/39f44daa-6e3d-4749-942b-538d255e4da6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

