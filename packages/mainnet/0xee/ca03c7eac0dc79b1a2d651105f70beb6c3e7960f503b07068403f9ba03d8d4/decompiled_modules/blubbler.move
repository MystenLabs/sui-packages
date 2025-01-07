module 0xeeca03c7eac0dc79b1a2d651105f70beb6c3e7960f503b07068403f9ba03d8d4::blubbler {
    struct BLUBBLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBBLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBBLER>(arg0, 6, b"BLUBBLER", b"Blubbler", b" Blubbler is the bubbliest token out there!  Swim thru the crypto seas, makin gains and LOLs along the way. Join the $BLUBBLER fam and ride the wave of fun and rewards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deploy_d8b8e3deb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBBLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBBLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

