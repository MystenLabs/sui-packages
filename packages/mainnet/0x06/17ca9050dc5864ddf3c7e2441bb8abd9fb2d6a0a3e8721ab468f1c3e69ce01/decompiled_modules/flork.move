module 0x617ca9050dc5864ddf3c7e2441bb8abd9fb2d6a0a3e8721ab468f1c3e69ce01::flork {
    struct FLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLORK>(arg0, 6, b"Flork", b"Flork meme", b"FLORK is based from the iconic meme Flork and will be launched on Sui Network. Flork is a webcomic that started in January of 2012. It first started as a simple WordPress comic for the creator to vent his frustrations with coding, but later migrated to Facebook and Reddit, its surreal and dark humor maturing in accordance with individual strips going viral as reaction images.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_15_18_48_2061191ae9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

