module 0x23f4f865b00c5371c9341ee3e7ef0e8dbe2e8afe4a8885999d4b715166f641a::but {
    struct BUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUT>(arg0, 9, b"BUT", b"Sadbutrich", b"Stay rich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a02dbe33-7b89-4e4e-8e18-a6cedf9b2fef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

