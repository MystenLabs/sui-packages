module 0xa55cfb81e7e76477410de4b22a50bcefa86df3946828dd344eaeeecf3db38689::rum {
    struct RUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUM>(arg0, 9, b"RUM", b"RUM", b"The next generation of video, streaming and cloud!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1678314685811007489/BRdyaZN__400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUM>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

