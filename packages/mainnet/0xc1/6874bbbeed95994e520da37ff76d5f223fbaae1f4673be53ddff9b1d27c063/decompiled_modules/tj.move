module 0xc16874bbbeed95994e520da37ff76d5f223fbaae1f4673be53ddff9b1d27c063::tj {
    struct TJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJ>(arg0, 9, b"TJ", b"Dex", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e63d746-14c0-4712-bb22-017fddf4a360.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

