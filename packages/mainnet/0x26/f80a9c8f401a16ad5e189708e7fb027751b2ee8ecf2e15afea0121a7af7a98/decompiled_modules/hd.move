module 0x26f80a9c8f401a16ad5e189708e7fb027751b2ee8ecf2e15afea0121a7af7a98::hd {
    struct HD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HD>(arg0, 6, b"HD", b"HOOD", b"THE HOOD MEME TOKEN IS CREATED SOLELY FOR ENTERTAINMENT PURPOSES AND IS NOT A FINANCIAL INVESTMENT. THIS PAGE IS CREATED BY A MEMBER OF THE COMMUNITY AS A FAN PAGE. YOU CAN ALWAYS LOSE EVERYTHING. THERE IS NO ROADMAP. COMMUNITY DECIDES THE FUTURE OF THIS TOKEN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_f67a9f46fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HD>>(v1);
    }

    // decompiled from Move bytecode v6
}

