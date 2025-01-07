module 0xd87f37602a87926e857103dff8bf244651346d8c05e98ee428d1bb50cb5ff015::chkp {
    struct CHKP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHKP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHKP>(arg0, 6, b"CHKP", b"CHUNKY PELICAN", b"Big beak, bigger dreams. Chunky Pelican is scooping up gains for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_042840218_bed740a53b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHKP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHKP>>(v1);
    }

    // decompiled from Move bytecode v6
}

