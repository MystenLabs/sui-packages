module 0xdb18ce7ff23a28aec1ff652eadd3fa52fd52e53d67cfb1d3f227362cae5574b7::swn {
    struct SWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWN>(arg0, 9, b"SWN", b"SWANSUI", b"Meme coin on SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78627f01-1649-4eb8-8f95-9b0896f00cae-1000149602.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

