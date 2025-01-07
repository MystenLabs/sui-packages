module 0xab84c10d6dc613a0829e4dbd7b200157ca9dd989c8548f3037f897a4231f8470::kit {
    struct KIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIT>(arg0, 9, b"KIT", b"Kitten", b"Meme is our future that has come now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6119cb8-6297-46ae-9241-5cfcedd447b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

