module 0xa1642c911b8aab9e2261073894ee14ee7ee4e4fbd18e58be57ed2624e2e4a0e5::danp {
    struct DANP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANP>(arg0, 9, b"DANP", b"Dan", b"This token is private token of Daniel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/222d6669-142c-4d77-ad65-17fb5f37fa82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DANP>>(v1);
    }

    // decompiled from Move bytecode v6
}

