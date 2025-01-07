module 0xca99bd177f9c0904dd96d2dd2ccc6b4df48c9c760169aac7a125490c9ff74bfe::vibelaunch {
    struct VIBELAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBELAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIBELAUNCH>(arg0, 6, b"VibeLaunch", b"vibe", b"$Vibe stealth launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K_Ruf2_Yxm_400x400_a664428805.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBELAUNCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBELAUNCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

