module 0x5e770dfd3478f95983801459b926773c56c4e6dc8bd2a656d5b4bdff83bd05a6::cai {
    struct CAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAI>(arg0, 9, b"CAI", b"CansAI", b"Aa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c0920b9-e287-4f03-9a51-8de258b3a6d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

