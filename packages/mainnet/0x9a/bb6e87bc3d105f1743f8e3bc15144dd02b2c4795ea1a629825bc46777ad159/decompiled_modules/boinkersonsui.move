module 0x9abb6e87bc3d105f1743f8e3bc15144dd02b2c4795ea1a629825bc46777ad159::boinkersonsui {
    struct BOINKERSONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOINKERSONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOINKERSONSUI>(arg0, 6, b"BOINKERSONSUI", b"Boinkers", b"Yes, its time, the popular boink game is now on sui, lets take some shitty ride to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241007_221802_692_4b61153012.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOINKERSONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOINKERSONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

