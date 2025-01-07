module 0x8966fd257b7461e237de8cd7c37d5ec451877469674028e432626dcb9fa226fe::mommo {
    struct MOMMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMMO>(arg0, 9, b"MOMMO", b"Mommo", b"Classic meme token with capabilities of reaching the top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1745345701188673536/5uVqYtz9.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOMMO>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

