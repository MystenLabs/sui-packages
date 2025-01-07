module 0x551da04aa53aeb0f4785a3aced8981f27cacd03ec9d5f034e48be1ad2e820e1b::wwry {
    struct WWRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWRY>(arg0, 6, b"WWRY", b"WE WILL RUG YOU", x"73746f6d702073746f6d7020636c61700a2d667265646479206d65726375726965", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_51572d4a4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

