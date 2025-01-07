module 0x138f6df258d8708d23d2e0b829d0b5b9e5cd74dbf7d52923edefe8c23bbff9ed::maon {
    struct MAON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAON>(arg0, 6, b"MAON", b"MAON SUI", b"MASUI, the playful and energetic mascot of Tesla, embodying the company's relentless pursuit of innovation and its drive to push the boundaries of technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gb_Nlb_Ocak_A_Af712_6ff6d5e5a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAON>>(v1);
    }

    // decompiled from Move bytecode v6
}

