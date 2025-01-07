module 0x54e1e45e7740a75edd12b0ac4e7f6adde7490d00780412e01951a519b14768c4::birddog {
    struct BIRDDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDDOG>(arg0, 9, b"BIRDDOG", b"Bird-Dog", b"Part bird, part dog, all legend! Members of BoysClub  https://www.birddogonsui.fun/ https://t.me/birddogsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729087899622-139e07d1fc82ec4f09358b286bd7e82f.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIRDDOG>(&mut v2, 169000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

