module 0xd35d8086d862171e26706a6b2da93465ac76a7bdffe6ea653d98f1fc2a04088b::time {
    struct TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIME>(arg0, 9, b"TIME", b"time", b"TIMEF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73579a5b-32d4-4f02-8be1-190fd4ac4cc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

