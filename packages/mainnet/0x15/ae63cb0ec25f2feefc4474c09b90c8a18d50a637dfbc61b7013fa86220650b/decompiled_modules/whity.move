module 0x15ae63cb0ec25f2feefc4474c09b90c8a18d50a637dfbc61b7013fa86220650b::whity {
    struct WHITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITY>(arg0, 9, b"WHITY", b"Whity", b"A very rich white cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3cca319-d6c7-4569-a103-b76920fae245.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

