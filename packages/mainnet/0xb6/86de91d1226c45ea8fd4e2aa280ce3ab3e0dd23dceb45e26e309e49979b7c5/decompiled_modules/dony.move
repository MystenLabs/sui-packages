module 0xb686de91d1226c45ea8fd4e2aa280ce3ab3e0dd23dceb45e26e309e49979b7c5::dony {
    struct DONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONY>(arg0, 9, b"DONY", b"Donya", b"Don't eat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7acec9bd-e5ca-4252-b0dd-d8b1e9fec366.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

