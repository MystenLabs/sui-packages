module 0x915875f1c9f048a79d5509da65262334306c46553ab02a02abe384c280b69cb5::mnj {
    struct MNJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNJ>(arg0, 9, b"MNJ", b"Kim Minji", b"Just for Kim Minji out there", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3bfb79bf-d728-4eb8-a60c-929b32c3574b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

