module 0x9e18803c4a803229dc891c68d29eee4d45c4c497338548c7c46455b4ee83539::fear {
    struct FEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEAR>(arg0, 9, b"FEAR", b"FEARCOIN", b"STAY AWAY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca889213-9763-4f03-9d49-948530e24ba1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

