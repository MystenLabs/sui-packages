module 0x2d3216f45ee28e9dbdac3ce4fd4cb546f6ce1337298c1f8d2540a12769c579d3::KX {
    struct KX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KX>(arg0, 6, b"KX", b"Kermit Xuixide", b"Noooo you're so hot - don't kill yourself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmRzcDUe6EKt8WGd3uoQ6y2AifpiUDdL1Jui3Em2b68dKE")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

