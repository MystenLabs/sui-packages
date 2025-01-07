module 0x11e72e28344324713e29740bba26a2153056cd44305dfa8a841407baaa8ac140::picoin {
    struct PICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICOIN>(arg0, 9, b"PICOIN", b"Pi Network", b"Official pi network coin by nicolas kokkalis team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29f7d1ac-06b6-4a8c-8179-3f5cc581335e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PICOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

