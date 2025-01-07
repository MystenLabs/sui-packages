module 0x8c9f2a1ab3bbd5b6bd11e245b34946a367402648de16979db5d616828c9e490a::bkg {
    struct BKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKG>(arg0, 9, b"BKG", b"Bear King", b"Bear King MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1d27b18-d12b-4ec0-bccc-ca72a0d6420c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

