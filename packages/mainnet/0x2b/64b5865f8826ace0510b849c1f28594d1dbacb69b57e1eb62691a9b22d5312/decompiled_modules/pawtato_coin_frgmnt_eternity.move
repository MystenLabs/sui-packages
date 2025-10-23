module 0x2b64b5865f8826ace0510b849c1f28594d1dbacb69b57e1eb62691a9b22d5312::pawtato_coin_frgmnt_eternity {
    struct PAWTATO_COIN_FRGMNT_ETERNITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_ETERNITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_ETERNITY>(arg0, 9, b"FRGMT_ETERNITY", b"Pawtato Fragment of Eternity", b"It defies decay and time alike. Those who gaze into it feel infinite lifetimes reflected back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-eternity.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_ETERNITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_ETERNITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

