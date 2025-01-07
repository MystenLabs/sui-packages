module 0x94721b5636b9bf6e4c9b7cfe49d2d5de20ddc9e949ac6490a884248a9d631ffd::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 9, b"MARIO", b"Suiper Mario", b"Suiper Mario Bros", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1634420790119763968/qy0qsO_F.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARIO>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

