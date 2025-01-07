module 0xc5b7896e4dbd038b72685ef501e5597f3e200fad7383def744d3bfb69923ffa9::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"MOG TRUMP", b"MOG TRUMP, originating as a lighthearted meme among friends, is poised to revolutionize the cryptocurrency world as the internets first culture coin. Scheduled for a Summer 2024 launch, this fair launch memecoin has rapidly grown from a playful joke into a significant phenomenon, captivating a global community with its unique concept and vision. MOG TRUMP is debuting cultural memecoin in 2024.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mog_ea6af586a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

