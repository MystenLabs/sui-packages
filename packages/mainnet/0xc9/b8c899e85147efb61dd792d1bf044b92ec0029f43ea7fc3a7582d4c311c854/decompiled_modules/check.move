module 0xc9b8c899e85147efb61dd792d1bf044b92ec0029f43ea7fc3a7582d4c311c854::check {
    struct CHECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHECK>(arg0, 6, b"CHECK", b"Blue Check on Sui", b"Verified as The First Blue Check on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bluecheck_on_sui_presisi_d81c02fabd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHECK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHECK>>(v1);
    }

    // decompiled from Move bytecode v6
}

