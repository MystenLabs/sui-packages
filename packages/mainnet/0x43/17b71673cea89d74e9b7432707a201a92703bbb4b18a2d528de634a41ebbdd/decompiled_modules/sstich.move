module 0x4317b71673cea89d74e9b7432707a201a92703bbb4b18a2d528de634a41ebbdd::sstich {
    struct SSTICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSTICH>(arg0, 6, b"SSTICH", b"SUI STITCH", b"Unofficial Sui Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stich_4741a4696c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSTICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSTICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

