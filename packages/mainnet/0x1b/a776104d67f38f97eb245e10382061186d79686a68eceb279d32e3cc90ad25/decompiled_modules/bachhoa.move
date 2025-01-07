module 0x1ba776104d67f38f97eb245e10382061186d79686a68eceb279d32e3cc90ad25::bachhoa {
    struct BACHHOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACHHOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACHHOA>(arg0, 9, b"BACHHOA", b"BACHHOAXEL", b"KING MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f684cb6-6173-4b63-bcce-1cbb2598f1eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACHHOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BACHHOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

