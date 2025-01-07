module 0xff292742963ecae5963d20e061d70d1ea4ecf11ddaa91eabcf4b1343810ebc9e::fuckcat1 {
    struct FUCKCAT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKCAT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKCAT1>(arg0, 9, b"FUCKCAT1", b"Fuckcat", b"Fuck cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5dae9595-548a-4033-8c68-2600910fb9e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKCAT1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCKCAT1>>(v1);
    }

    // decompiled from Move bytecode v6
}

