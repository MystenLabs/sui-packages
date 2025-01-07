module 0x207bbbf1c0f462bc97206a429781e34a155f43bfc3b6f3d4a481ee6b9ec258af::lucky {
    struct LUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY>(arg0, 9, b"LUCKY", b"Lucky coin", b"Good luck for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dae9adda-04c9-4c4a-a036-bec577b16995.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

