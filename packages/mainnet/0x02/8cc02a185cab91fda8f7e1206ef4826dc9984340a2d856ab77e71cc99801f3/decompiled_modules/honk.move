module 0x28cc02a185cab91fda8f7e1206ef4826dc9984340a2d856ab77e71cc99801f3::honk {
    struct HONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONK>(arg0, 6, b"Honk", b"Honk-Bonk", b"The Honk-Bonk rivalry is one of the most epic rivalries in internet meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1201728832428_pic_f4b6f64feb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

