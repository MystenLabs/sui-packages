module 0x60491719592ac0442203d35411e76a5123f3f9d5cf35ed77a2bf4daace7ecad2::arts {
    struct ARTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTS>(arg0, 9, b"ARTS", b"Artiscent", b"A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b12be5f3-2a2f-4692-96f4-3d094613bf51.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

