module 0x29b3c56935740a385e8e06cb0fbd65895c69d79c18a33a90349cfb2db3aa3e35::kom {
    struct KOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOM>(arg0, 9, b"KOM", b"kingofmeme", b"KING OF MEMES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31913404-9a82-42b1-8516-3e48b483745b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

