module 0x89f506aceb6487685ddbe24402106d49ba29d18da37d31ed287fac7376139fd::wlf {
    struct WLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLF>(arg0, 9, b"WLF", b"Wolfie", b"Mean wolf meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee9f7814-037a-4701-bc22-118441427373.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

