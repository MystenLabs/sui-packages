module 0x43b64be5b74bf3eb1b703fbc06b6b2418018c641a4d2eb0a6c8f928fb9ac6a1f::fat {
    struct FAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAT>(arg0, 9, b"FAT", b"WC FAT MAN", b"Wealth Circuit's FAT MAN MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e71823b-a714-4ab1-a724-4428f6a5d0f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

