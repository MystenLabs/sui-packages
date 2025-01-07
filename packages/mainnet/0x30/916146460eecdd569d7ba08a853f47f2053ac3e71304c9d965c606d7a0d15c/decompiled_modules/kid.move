module 0x30916146460eecdd569d7ba08a853f47f2053ac3e71304c9d965c606d7a0d15c::kid {
    struct KID has drop {
        dummy_field: bool,
    }

    fun init(arg0: KID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KID>(arg0, 9, b"KID", b"Rich Kid", b"FOR THE CULTURE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/277682f7-dc71-4668-a99c-558cc047abf4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KID>>(v1);
    }

    // decompiled from Move bytecode v6
}

