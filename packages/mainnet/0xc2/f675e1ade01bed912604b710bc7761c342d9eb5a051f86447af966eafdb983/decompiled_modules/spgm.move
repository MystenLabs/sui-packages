module 0xc2f675e1ade01bed912604b710bc7761c342d9eb5a051f86447af966eafdb983::spgm {
    struct SPGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPGM>(arg0, 6, b"SPGM", b"SpongeMoon", b"The coin that proves even from the deepest oceans, we can ascend to lunar heights. Inspired by the whimsical tale of a sponge discovering the moon underwater, SPGM embodies the spirit of reaching for the stars no matter where you start.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971485076.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPGM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPGM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

