module 0x44593eabf9fb8b357c373c90db55bd639abf24d4055892a8b66385f3c25dd55a::prf {
    struct PRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRF>(arg0, 9, b"PRF", b"Perfume", b"guess my job, by the way wear perfume everyday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36d978ed-3e1a-48b1-99f6-f6e1940d9cfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

