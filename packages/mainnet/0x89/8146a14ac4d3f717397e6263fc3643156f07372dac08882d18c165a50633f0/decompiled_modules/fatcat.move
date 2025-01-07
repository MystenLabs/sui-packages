module 0x898146a14ac4d3f717397e6263fc3643156f07372dac08882d18c165a50633f0::fatcat {
    struct FATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATCAT>(arg0, 9, b"FATCAT", b"Fat Cat", b"World fastest cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed647c06-dcd8-4cb0-b258-7c837799421d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

