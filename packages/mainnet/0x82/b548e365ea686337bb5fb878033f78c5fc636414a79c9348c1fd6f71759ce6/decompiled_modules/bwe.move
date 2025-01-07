module 0x82b548e365ea686337bb5fb878033f78c5fc636414a79c9348c1fd6f71759ce6::bwe {
    struct BWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWE>(arg0, 9, b"BWE", b"Bwewe", b"Dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b598305-cf9c-4aae-b43a-3ea0dc5c6dd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

