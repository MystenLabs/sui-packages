module 0x428bba6c5f4cca7ad5abb10d5656ff1cf95ef0164e974161634c34b4a89ae6e9::punch {
    struct PUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNCH>(arg0, 9, b"PUNCH", b"One Punch", b"One punch and your balace go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebbfbc88-a4c5-4d71-bc1a-f2f47cb5f539.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

