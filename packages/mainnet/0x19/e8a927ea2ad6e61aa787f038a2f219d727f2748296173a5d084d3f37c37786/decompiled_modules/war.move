module 0x19e8a927ea2ad6e61aa787f038a2f219d727f2748296173a5d084d3f37c37786::war {
    struct WAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAR>(arg0, 6, b"WAR", b"Sui War", b"No War", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000107139_b08509bb25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

