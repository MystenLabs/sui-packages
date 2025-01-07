module 0x801678aaa2f9c6a82b6d59004f39e268761d19c5f53f52cf31654ea15aa42aae::msg {
    struct MSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSG>(arg0, 9, b"MSG", b"crypt-message", b"Who knows what is behind this cryptic message", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f331b0fe5d9a1518e5269e0287ffe691blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

