module 0x46993c2d3478d6570591eb05f7278cfe28a90a8c51af95fa278286556d7fb635::mnt {
    struct MNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNT>(arg0, 6, b"MNT", b"Minati", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/465fd01b-a218-4a13-ae6e-b85db401b652.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MNT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

