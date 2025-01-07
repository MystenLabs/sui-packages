module 0xaba11f6a316e3f3ba9ea4858461e55e897a5489ef81fb20c5e5c25e2aacca9b1::pico {
    struct PICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICO>(arg0, 6, b"PICO", b"Picolas Cage", b"Nick Cages Picol Lets Tickle the Picol and send this to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_03_065000_30fccc698d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICO>>(v1);
    }

    // decompiled from Move bytecode v6
}

