module 0x6416589d388360633d65bac3cba8897ef95a691c78570524f6911bb4329716da::znd {
    struct ZND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZND>(arg0, 9, b"ZND", b"Zendaya", b"I am an Abyssinian pedigree cat and I am lucky. However, there are many homeless cats and kittens roaming the streets, let's help them buy food together?!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a45d4de5-f1f9-4a00-82ec-b8c0272bf914-IMG_3420.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZND>>(v1);
    }

    // decompiled from Move bytecode v6
}

