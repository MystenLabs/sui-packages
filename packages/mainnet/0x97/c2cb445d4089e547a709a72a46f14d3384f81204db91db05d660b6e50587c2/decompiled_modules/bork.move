module 0x97c2cb445d4089e547a709a72a46f14d3384f81204db91db05d660b6e50587c2::bork {
    struct BORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORK>(arg0, 6, b"BORK", b"Bork Inu", b"Bork Inu has learned a few tricks and lessons from his meme father, Doge. A new crypto birthed by fans of the Doge Meme online community. Bork seeks to impress his father by showing his new improved transaction speeds & adorableness. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_4b60809c9b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

