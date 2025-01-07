module 0xca83aebe8af216dfb8b32f73a519a9f206ca5e46c0767f86ccd7482a1f888216::octopass {
    struct OCTOPASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPASS>(arg0, 6, b"Octopass", b"OctofunSui", b"Octopass is coming to Sui market - A meme token acting like a meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000926077.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTOPASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

