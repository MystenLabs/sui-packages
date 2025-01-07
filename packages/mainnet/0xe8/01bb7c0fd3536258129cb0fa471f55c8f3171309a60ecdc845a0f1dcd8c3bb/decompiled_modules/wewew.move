module 0xe801bb7c0fd3536258129cb0fa471f55c8f3171309a60ecdc845a0f1dcd8c3bb::wewew {
    struct WEWEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEW>(arg0, 6, b"WEWEW", b"Wewe", b"Dive deeper into Wave Trading and be a part of the Sui Meme Culture, Waver!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028997_7af3a0a88d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEWEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

