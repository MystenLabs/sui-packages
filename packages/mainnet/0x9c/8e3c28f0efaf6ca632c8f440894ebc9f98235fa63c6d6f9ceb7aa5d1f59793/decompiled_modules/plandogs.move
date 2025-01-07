module 0x9c8e3c28f0efaf6ca632c8f440894ebc9f98235fa63c6d6f9ceb7aa5d1f59793::plandogs {
    struct PLANDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANDOGS>(arg0, 9, b"PLANDOGS", b"Dogj", b"Good meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbf049cf-bdcd-4601-b63a-51c7deade31c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLANDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

