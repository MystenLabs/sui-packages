module 0x8c1c8545d75c093872c16e92eca044203ff3c38a6c5651e0316c4eb1f25cc27c::trmp47 {
    struct TRMP47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMP47>(arg0, 9, b"TRMP47", b"47th Trump", b"A win for all!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09c180ae-acc1-4444-a9cb-23b3de14cd60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMP47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRMP47>>(v1);
    }

    // decompiled from Move bytecode v6
}

