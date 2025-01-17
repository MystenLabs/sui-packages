module 0xd21395aab6a20e230e4554beb2db2ecd608a5a8fd13d788fa66c36acc3d43a9a::dpump {
    struct DPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPUMP>(arg0, 6, b"DPUMP", b"Donald AI Pump", b"Donald AI Pump is not only a memecoin but also an innovative AI-powered agent on the SUI blockchain, delivering cutting-edge tools for chart analysis, trend detection, wallet tracking, and trading insights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Immagine_2025_01_17_143937_4443d921f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

