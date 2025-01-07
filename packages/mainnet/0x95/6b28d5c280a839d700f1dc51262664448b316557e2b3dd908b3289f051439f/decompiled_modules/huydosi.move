module 0x956b28d5c280a839d700f1dc51262664448b316557e2b3dd908b3289f051439f::huydosi {
    struct HUYDOSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUYDOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUYDOSI>(arg0, 9, b"HUYDOSI", b"Huydosi", b"NFTs for ALL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49edce39-a3eb-4492-883f-6610ff6d6630.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUYDOSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUYDOSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

