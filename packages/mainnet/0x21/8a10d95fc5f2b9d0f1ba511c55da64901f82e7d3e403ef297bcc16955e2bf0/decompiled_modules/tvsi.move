module 0x218a10d95fc5f2b9d0f1ba511c55da64901f82e7d3e403ef297bcc16955e2bf0::tvsi {
    struct TVSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVSI>(arg0, 9, b"TVSI", b"Trump VS Iran", b"The global president loves to shake hands with everyone. This token will bring hope for handshakes around the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d159c7573218ce4715dab155854bee80blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TVSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVSI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

