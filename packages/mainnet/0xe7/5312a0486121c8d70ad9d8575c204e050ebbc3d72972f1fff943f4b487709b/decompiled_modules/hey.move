module 0xe75312a0486121c8d70ad9d8575c204e050ebbc3d72972f1fff943f4b487709b::hey {
    struct HEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEY>(arg0, 9, b"HEY", b"HEY", b"Hunting either yumming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.huntshowdown.com/assets/img/hero.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

