module 0xccf70d0ff117af5c93376b1e0adb0334a4f9bb688ff152848bcc743d0aeb6e3b::mimi {
    struct MIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIMI>(arg0, 6, b"MIMI", b"Mimi", b"mimimimimimimimimimi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042205_f790dac059.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

