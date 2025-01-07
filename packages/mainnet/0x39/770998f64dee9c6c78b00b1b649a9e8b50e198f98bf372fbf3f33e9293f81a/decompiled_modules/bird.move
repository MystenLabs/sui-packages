module 0x39770998f64dee9c6c78b00b1b649a9e8b50e198f98bf372fbf3f33e9293f81a::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 9, b"BIRD", b"Sui Birds", b"https://t.me/birdx2_bot/birdx?startapp=5682202369", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845075905103921152/n3k9p2gT.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIRD>(&mut v2, 750000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

