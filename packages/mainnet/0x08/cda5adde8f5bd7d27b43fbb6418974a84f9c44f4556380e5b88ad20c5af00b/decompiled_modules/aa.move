module 0x8cda5adde8f5bd7d27b43fbb6418974a84f9c44f4556380e5b88ad20c5af00b::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AA>(arg0, 9, b"AA", b"ANIMA AI", b"ai based anime coin meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7cd49c29-f7ee-4ee0-a44f-2aa294ed0b5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AA>>(v1);
    }

    // decompiled from Move bytecode v6
}

