module 0x938cd0c8f61780e333ddf41e12931af9e50f9f4cb93e55a76654fc9534503237::bgain {
    struct BGAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGAIN>(arg0, 9, b"BGAIN", b"ByteGain", b"Youtube Channel Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab1148ce-77ba-422e-a55f-17d1a6c606c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

