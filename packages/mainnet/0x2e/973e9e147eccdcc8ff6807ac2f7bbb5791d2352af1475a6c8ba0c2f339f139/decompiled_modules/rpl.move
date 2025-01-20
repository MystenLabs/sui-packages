module 0x2e973e9e147eccdcc8ff6807ac2f7bbb5791d2352af1475a6c8ba0c2f339f139::rpl {
    struct RPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPL>(arg0, 9, b"RPL", b"Riplin", b"minbala2015@gmail.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51f598f4-607c-47f5-aec4-1a190b9ba652.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

