module 0x70f559c100378918be06c185150f9b5d8a876465d733178683a74f1b238a52cb::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMU>(arg0, 8, b"MUMU", b"Mumu the Bull", b"Mumu the Bull No1 Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-deep-eel-22.mypinata.cloud/ipfs/QmbuCSCpP5tYCpXAK8GuhPzYJsj1vsQREj7ZY34rFGm8wZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUMU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

