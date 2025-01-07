module 0x5f029988289a37f60e20ba9245f0817a93efe782250eeb558b04f0d0f6ced81a::sfer {
    struct SFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFER>(arg0, 6, b"SFER", b"Sui mfer", b"Sui is a muthafucka", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_dfda791863.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

