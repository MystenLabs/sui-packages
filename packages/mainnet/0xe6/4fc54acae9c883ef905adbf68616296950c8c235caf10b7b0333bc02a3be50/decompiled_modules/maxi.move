module 0xe64fc54acae9c883ef905adbf68616296950c8c235caf10b7b0333bc02a3be50::maxi {
    struct MAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXI>(arg0, 9, b"MAXI", b"Maxi Meme", b"$MAXI is a meme of Moxie Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f88b37f-bc48-4c66-929c-1dc4a807e66d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

