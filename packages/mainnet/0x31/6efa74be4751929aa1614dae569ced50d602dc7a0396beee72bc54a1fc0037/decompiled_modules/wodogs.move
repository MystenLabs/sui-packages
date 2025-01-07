module 0x316efa74be4751929aa1614dae569ced50d602dc7a0396beee72bc54a1fc0037::wodogs {
    struct WODOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WODOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WODOGS>(arg0, 9, b"WODOGS", b"Galimeme", b"Ez money to making ....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cea7d0e7-1c97-4f88-bd07-dbe2bbb060b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WODOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WODOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

