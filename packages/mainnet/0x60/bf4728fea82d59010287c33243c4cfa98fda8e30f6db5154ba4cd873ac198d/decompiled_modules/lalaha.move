module 0x60bf4728fea82d59010287c33243c4cfa98fda8e30f6db5154ba4cd873ac198d::lalaha {
    struct LALAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALAHA>(arg0, 9, b"LALAHA", b"Lalana", b"Gud morninh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cc46bec-bf60-4449-a4d9-447e353e6dac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

