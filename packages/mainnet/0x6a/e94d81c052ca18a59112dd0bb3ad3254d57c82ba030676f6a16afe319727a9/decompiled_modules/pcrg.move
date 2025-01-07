module 0x6ae94d81c052ca18a59112dd0bb3ad3254d57c82ba030676f6a16afe319727a9::pcrg {
    struct PCRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCRG>(arg0, 6, b"PCRG", b"Persian Cat Room Guardian", b"The Persian Cat Room Guardian has opened the door of the church to Valhalla ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XCVHZ_Cu_400x400_13bd54373d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

