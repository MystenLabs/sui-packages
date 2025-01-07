module 0x4377069f3eddb4ac82372250135a027d9ea46185fc336b7bac345da2bdd9e7da::pk {
    struct PK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PK>(arg0, 9, b"PK", b"Poonam ", b"Cryptovibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aab110d9-64f4-4fd6-843b-2fe242faed9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PK>>(v1);
    }

    // decompiled from Move bytecode v6
}

