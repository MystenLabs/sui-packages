module 0x7d5df9d17fb43fecb91514945ab799d267bfed917d1386a7c2795a091cbed77f::microdoge {
    struct MICRODOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICRODOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICRODOGE>(arg0, 6, b"Microdoge", b"Micro doge", b"The newest and tiniest member of the Doge family! While MicroDoge may be starting small, its packed with potential to grow into a giant in the crypto community, proving that great things often come in tiny packages! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_08_19_49_56_f29b082b25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICRODOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICRODOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

