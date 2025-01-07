module 0x7006f29ebfa15a30d3ee27950ac9ce208a02fd64ef9ccabb0ab7f7b505a0aebc::emj {
    struct EMJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMJ>(arg0, 9, b"EMJ", b"Emoji", b"emoji is from different smileys token for bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4056baf2-9ba3-494a-ab53-db3d67d6e3d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

