module 0x8b2a37f36d1a7d5e75c67e45106d1959b5b23536626e6cea23e8f2caa9ccf916::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 9, b"SS", b"SeaSprout", b"$$$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQf8Crm6RrJTOchHPdaD0mYGhvzXL0LZFVmbg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

