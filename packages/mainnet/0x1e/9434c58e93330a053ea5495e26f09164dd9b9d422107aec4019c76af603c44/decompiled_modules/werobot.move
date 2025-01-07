module 0x1e9434c58e93330a053ea5495e26f09164dd9b9d422107aec4019c76af603c44::werobot {
    struct WEROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEROBOT>(arg0, 6, b"WEROBOT", b"We Robot", b"https://x.com/elonmusk/status/1844548290681192896", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wer_971f53ba92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

