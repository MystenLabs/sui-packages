module 0xe12f9eba62aadb18e60a07c2279aac7668c25084a2b3eaa6748806ec324ed826::met {
    struct MET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MET>(arg0, 9, b"MET", b"mate", b"Community first let ride to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb87deff-5202-4ce9-8880-10eea34b6791.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MET>>(v1);
    }

    // decompiled from Move bytecode v6
}

