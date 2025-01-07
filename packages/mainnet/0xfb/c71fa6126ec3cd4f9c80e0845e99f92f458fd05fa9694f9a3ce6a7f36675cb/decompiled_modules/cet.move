module 0xfbc71fa6126ec3cd4f9c80e0845e99f92f458fd05fa9694f9a3ce6a7f36675cb::cet {
    struct CET has drop {
        dummy_field: bool,
    }

    fun init(arg0: CET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CET>(arg0, 9, b"CET", b"Ceta", b"The meme coin that will bring tremendous growth to the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb615389-e516-4b62-b55d-47d661271121.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CET>>(v1);
    }

    // decompiled from Move bytecode v6
}

