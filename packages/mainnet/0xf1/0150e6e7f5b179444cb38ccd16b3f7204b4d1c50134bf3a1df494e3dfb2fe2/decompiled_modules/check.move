module 0xf10150e6e7f5b179444cb38ccd16b3f7204b4d1c50134bf3a1df494e3dfb2fe2::check {
    struct CHECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHECK>(arg0, 6, b"CHECK", b"Blue Check on SUI", b"Verified as The First Blue Check on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bluecheck_on_sui_presisi_a9e35a3691.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHECK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHECK>>(v1);
    }

    // decompiled from Move bytecode v6
}

