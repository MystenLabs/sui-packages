module 0x17661649c552850e2bd3ec204af45fda5bfd3a5c3e91188465fdfc12e16c082e::skp {
    struct SKP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKP>(arg0, 9, b"SKP", b"Soul Keep", b"Keep My Token To Keep Your Soul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ca14c77-c8cb-4a3b-8c31-16b700eec90b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKP>>(v1);
    }

    // decompiled from Move bytecode v6
}

